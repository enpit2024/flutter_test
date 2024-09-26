import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                )));
  }
}
