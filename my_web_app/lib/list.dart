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
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('ゆきと'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('ひろと'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('いより'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        )

        // body: Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Text('Go back!'),
        //   ),
        // ),
        );
  }
}
