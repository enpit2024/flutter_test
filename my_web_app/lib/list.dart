import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Next Page'),
          backgroundColor: const Color(0xFF00FF00),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Map'),
                subtitle: const Text('これはサブタイトルです'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text('Album'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Phone'),
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
