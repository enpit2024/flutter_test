import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/main.dart';
import 'package:my_web_app/model/himapeople.dart';
import 'package:my_web_app/firebase/firestore.dart';
import 'package:my_web_app/name_reg.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<HimaPeople> himapeopleSnapshot = [];
  List<HimaPeople> himaPeople = [];
  bool isLoading = false;
  late String name;

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
    });
  }

  Future<void> _refresh() async {
    await get();
    return Future.delayed(
      const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('暇な人リスト'),
        backgroundColor: const Color(0xFF00FF00),
      ),
      body: Center(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(),
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad
            },
          ),
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  // ListTile(
                  //   leading: const Icon(Icons.person),
                  //   title: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  //       const Text('Name'),
                  //       const Text('Deadline'),
                  //       const Text('Place'),
                  //     ],
                  //   ),
                  // ),
                  for (var person in himaPeople)
                    if (person.isHima)
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(person.name ?? person.mail),
                            Text('~00:00'),
                            Text('テスト'),
                          ],
                        ),
                      ),
                ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.lightBlue, // Light blue color
        elevation: 8.0,
        shape: const CircleBorder(), // Ensures a perfect circle shape
        onPressed: () async {
          DateTime now = DateTime.now();
          String formattedTime = "${now.hour}:${now.minute}";

          // ユーザー情報を取得
          final user = FirebaseAuth.instance.currentUser;
          final uid = user?.uid;
          final email = user?.email;

          // ログインできているか確認
          bool isLogin = FirebaseAuth.instance.currentUser != null;
          print('isLogin: $isLogin');

          // ログインしていなければログイン画面に遷移
          if (!isLogin) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }

          print('uid: $uid');

          final snapshot = await FirebaseFirestore.instance
              .collection("users")
              .where("id", isEqualTo: uid)
              .get();

          HimaPeople newPerson;

          if (snapshot.docs.isEmpty) {
            newPerson = HimaPeople(
                id: '$uid', mail: '$email', isHima: true, name: '$name');
            await addHimaPerson(newPerson);
          } else {
            // snapshot.docs[0].data()の中身のisHimaを取得
            bool isHima = snapshot.docs[0].data()['isHima'];

            // snapshot.docs[0]のisHimaを反転
            await FirebaseFirestore.instance
                .collection("users")
                .doc(snapshot.docs[0].id)
                .update({'isHima': !isHima});
          }

          get();
        },
        child: const Text(
          '暇',
          style: TextStyle(
            fontSize: 36, // Increased font size
            fontWeight: FontWeight.bold, // Optional: makes the text bolder
            color: Colors.white, // Ensures good contrast with the background
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Friends',
          ),
        ],
      ),
    );
  }
}
