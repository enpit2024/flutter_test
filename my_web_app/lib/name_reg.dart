import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/firebase/firestore.dart';
import 'package:my_web_app/list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_web_app/model/himapeople.dart';
import 'package:my_web_app/signup_page.dart';
import 'firebase_options.dart';
import 'package:my_web_app/login_page.dart';

class NameReg extends StatefulWidget {
  const NameReg({super.key});

  @override
  State<NameReg> createState() => _NameRegState();
}

class _NameRegState extends State<NameReg> {
  final myController = TextEditingController();
  late String name;

  List<HimaPeople> himapeopleSnapshot = [];
  List<HimaPeople> himaPeople = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // getHimaPeople();
    get();
  }

  Future getHimaPeople() async {
    setState(() => isLoading = true);
    himaPeople = await FirestoreHelper.instance
        .selectAllHimaPeople("Ian4IDN4ryYtbv9h4igNeUdZQkB3");
    setState(() => isLoading = false);
  }

  // usersコレクションのドキュメントを全件読み込む
  Future get() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final himaPeople = snapshot.docs
        .map((doc) => HimaPeople.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
    setState(() {
      this.himaPeople = himaPeople;
    });
  }

  Future<void> addHimaPerson(HimaPeople person) async {
    await FirebaseFirestore.instance.collection('users').add({
      'id': person.id,
      'name': person.name,
      'isHima': person.isHima,
      'email': person.mail,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('名前登録!!'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: '名前',
              ),
              onChanged: (String value) {
                setState(() {
                  name = value;
                });
              },
            ),
            ElevatedButton(
              child: const Text('登録'),
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                final uid = user?.uid;
                final email = user?.email;

                // ログインできているか確認
                bool isLogin = FirebaseAuth.instance.currentUser != null;
                print('isLogin: $isLogin');

                // ログインしていなければログイン画面に遷移
                if (!isLogin) {
                  Navigator.pop(context);
                }

                print('uid: $uid');

                // FirebaseFirestore.instance.collection("users").where("id", isEqualTo: uid).get()に該当するドキュメントがあるか否か判定
                final snapshot = await FirebaseFirestore.instance
                    .collection("users")
                    .where("id", isEqualTo: uid)
                    .get();

                HimaPeople newPerson;

                if (snapshot.docs.isEmpty) {
                  newPerson = HimaPeople(
                    id: '$uid',
                    mail: '$email',
                    isHima: true,
                    name: name,
                    deadline: "",
                    place: "",
                  );
                  await addHimaPerson(newPerson);
                } else {
                  // snapshot.docs[0].data()の中身のisHimaを取得
                  bool isHima = snapshot.docs[0].data()['isHima'];

                  // snapshot.docs[0]のisHimaを反転
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(snapshot.docs[0].id)
                      .update({'name': name});
                }

                // Firestoreにデータを追加

                // getHimaPeople();
                get();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NextPage()));
// await Firestore.instance
                // TODO: 新規登録
              },
            ),
          ],
        ),
      ),
    );
  }
}
