import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

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
        onPressed: () {},
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
