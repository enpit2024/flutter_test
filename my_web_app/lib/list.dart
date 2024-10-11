import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/model/himapeople.dart';
import 'package:my_web_app/firebase/firestore.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<HimaPeople> himapeopleSnapshot = [];
  List<HimaPeople> himaPeople = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // getHimaPeople();
    get();
  }

  // Future getHimaPeople() async {
  //   setState(() => isLoading = true);
  //   himapeopleSnapshot = await FirestoreHelper.instance.selectAllHimaPeople(
  //       "Ian4IDN4ryYtbv9h4igNeUdZQkB3"); //←users配下のcatsコレクションのドキュメントを全件読み込む
  //   himaPeople = himapeopleSnapshot //←受け取ったDocumentsnapshotの値をListに変換する
  //       .map((doc) => HimaPeople(
  //             id: doc['id'],
  //             name: doc['name'],
  //             isHima: doc['isHima'],
  //           ))
  //       .toList();
  //   setState(() => isLoading = false);
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('暇な人リスト'),
        backgroundColor: const Color(0xFF00FF00),
      ),
      body: Center(
          child: ListView(children: <Widget>[
        ListTile(
          leading: const Icon(Icons.person),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text('Name'),
              const Text('Deadline'),
              const Text('Place'),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Container(
            width: 20,
            height: 20,
            child: Image.asset(
              'images/mob.png',
              fit: BoxFit.contain,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('ゆうき'),
              Text('~12:00'),
              Text('3学'),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('ゆきと'),
              Text('~12:00'),
              Text('3学'),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('いより'),
              Text('~12:00'),
              Text('3学'),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        for (var person in himaPeople)
          ListTile(
            leading: const Icon(Icons.person),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(person.name),
                Text('~00:00'),
                Text('テスト'),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
      ]

              //     ListTile(
              //       leading: const Icon(Icons.person),
              //       title: const Text('ひろと'),
              //       subtitle: Row(children: <Widget>[
              //         Text('12:00'),
              //         SizedBox(width: 10),
              //         Text('3学'),
              //       ]),
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //     ListTile(
              //       leading: const Icon(Icons.person),
              //       title: const Text('いより'),
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //   ],
              // ))

              // body: Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     child: const Text('Go back!'),
              //   ),
              // ),
              )),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          // 例として新しいHimaPeopleオブジェクトを作成
          DateTime now = DateTime.now();
          String formattedTime = "${now.hour}:${now.minute}";
          // ログインしている場合，ユーザーのemailを取得
          final user = FirebaseAuth.instance.currentUser;
          final uid = user?.uid;
          final email = user?.email;
          // firestoreのusersコレクションの任意のドキュメントのコレクションの中のidにuser?.uidがあるか確認
          // FirebaseFirestore.instance.collection("users").where("id", isEqualTo: uid).get().then((snapshot) {
          //   for (var doc in snapshot.docs) {
          //     print('${doc.id}: ${doc.data()['id']}, ${doc.data()['name']}, ${doc.data()['isHima']}');
          //   }
          // });

          // FirebaseFirestore.instance.collection("users").where("id", isEqualTo: uid).get()に該当するドキュメントがあるか否か判定
          final snapshot = await FirebaseFirestore.instance
              .collection("users")
              .where("id", isEqualTo: uid)
              .get();

          HimaPeople newPerson;

          if (snapshot.docs.isEmpty) {
            print('No such document!');
            newPerson = HimaPeople(id: '$uid', name: '$email', isHima: true);
          } else {
            print("snapshot.docs[0].id: ${snapshot.docs[0].id}");
            print('Document data: ${snapshot.docs[0].data()}');
            // snapshot.docs[0].data()の中身のisHimaを取得
            bool isHima = snapshot.docs[0].data()['isHima'];
            // snapshot.docs[0].data()を削除
            await FirebaseFirestore.instance
                .collection("users")
                .doc(snapshot.docs[0].id)
                .delete();

            print("isHima: $isHima");

            newPerson = HimaPeople(id: '$uid', name: '$email', isHima: !isHima);
          }

          // Firestoreにデータを追加
          await addHimaPerson(newPerson);

          // getHimaPeople();
          get();
        },
        child: Text(
          '暇',
          style: TextStyle(
            fontSize: 36, // Increased font size
            fontWeight: FontWeight.bold, // Optional: makes the text bolder
            color: Colors.white, // Ensures good contrast with the background
          ),
        ),
        backgroundColor: Colors.lightBlue, // Light blue color
        elevation: 8.0,
        shape: CircleBorder(), // Ensures a perfect circle shape
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
