import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_web_app/signup_page.dart';
import 'firebase_options.dart';
import 'package:my_web_app/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // ログイン済みならNextPage、未ログインならMyHomePageを表示
      home: FirebaseAuth.instance.currentUser == null
          ? const MyHomePage()
          : const NextPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = "ひマッチ";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.purple,
            ),
            child: const Text('ログイン'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignupPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.purple,
            ),
            child: const Text('新規登録'),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Container to set the background color
          Container(
            color: Colors.white, // Set background color here
          ),
          Center(
            child: Image.asset('images/ひマッチ@4x-100.jpg'),
          ),
          // Align(
          //   alignment: Alignment.centerRight, // 中央の右端に配置
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 16.0), // 右端に少し余白を追加
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => NextPage()));
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.grey[300],
          //         foregroundColor: Colors.purple,
          //       ),
          //       child: const Text('Button'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// class NextPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('【画面遷移デモ】2ページ'),
//         backgroundColor: Colors.red,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text("戻る"),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }
