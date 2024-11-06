import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/main.dart';
import 'package:my_web_app/model/himapeople.dart';
import 'package:my_web_app/firebase/firestore.dart';
import 'package:my_web_app/name_reg.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

  bool _isHima = false;
  String myperson = "";

  bool _switchValue = false; // トグルの状態を保持する変数

  @override
  void initState() {
    super.initState();
    _initializeAsync();
    get();
  }

  Future<void> _initializeAsync() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: uid)
        .get();

    bool isHima = snapshot.docs[0].data()['isHima'];

    setState(() {
      _isHima = isHima;
    });
  }

  Future getHimaPeople() async {
    setState(() => isLoading = true);
    himaPeople = await FirestoreHelper.instance
        .selectAllHimaPeople("Ian4IDN4ryYtbv9h4igNeUdZQkB3");
    setState(() => isLoading = false);
  }

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

  void _toggleHimaStatus(int index) async {
    DateTime now = DateTime.now();
    String formattedTime = "${now.hour}:${now.minute}";
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final email = user?.email;
    bool isLogin = FirebaseAuth.instance.currentUser != null;
    if (!isLogin) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    }
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: uid)
        .get();
    HimaPeople newPerson;
    bool isHima = true;
    if (snapshot.docs.isEmpty) {
      newPerson =
          HimaPeople(id: '$uid', mail: '$email', isHima: true, name: name);
      await addHimaPerson(newPerson);
    } else {
      isHima = snapshot.docs[0].data()['isHima'];
      await FirebaseFirestore.instance
          .collection("users")
          .doc(snapshot.docs[0].id)
          .update({'isHima': !isHima});
    }
    setState(() {
      _isHima = !isHima;
    });
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('暇な人リスト'),
        backgroundColor: Colors.lightBlue,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.lightBlue,
            ),
            child: const Text('ログアウト'),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              } catch (e) {
                setState(() {
                  var infoText = "ログアウトに失敗しました：${e.toString()}";
                });
              }
            },
          ),
        ],
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
                  const ListTile(
                    leading: Icon(Icons.person),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Name'),
                        Text('Deadline'),
                        Text('Place'),
                      ],
                    ),
                  ),
                  if (_isHima)
                    Container(
                      color: Colors.yellow[100],
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(himaPeople
                                    .firstWhere(
                                        (person) =>
                                            person.id ==
                                            FirebaseAuth
                                                .instance.currentUser?.uid,
                                        orElse: () => HimaPeople(
                                            id: '',
                                            mail: '',
                                            isHima: false,
                                            name: 'No Name'))
                                    .name ??
                                "No Name"),
                            const Text('~00:00'),
                            const Text('テスト')
                          ],
                        ),
                      ),
                    ),
                  for (var person in himaPeople)
                    if (person.isHima &&
                        person.id != FirebaseAuth.instance.currentUser?.uid)
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(person.name ?? "No Name"),
                            const Text('~00:00'),
                            const Text('テスト'),
                          ],
                        ),
                      ),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: ToggleSwitch(
            initialLabelIndex: _isHima ? 1 : 0,
            totalSwitches: 2,
            labels: ['忙', '暇'],
            onToggle: (index) {
              _toggleHimaStatus(index!);
            },
          ),
        ),
      ),
    );
  }
}
