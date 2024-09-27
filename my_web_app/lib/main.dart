import 'package:flutter/material.dart';

void main() {
  runApp(const LoginSample());
}

class LoginSample extends StatelessWidget {
  const LoginSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login Sample',
      // home: const MyHomePage(title: 'Login Sample'),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {},
              ),
              // パスワード入力
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {},
              ),

              SizedBox(
                width: double.infinity,
                // ユーザー登録ボタン
                child: ElevatedButton(
                  child: const Text('ユーザー登録'),
                  onPressed: () {
                    debugPrint('ユーザー登録');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
