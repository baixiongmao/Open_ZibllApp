import 'package:flutter/material.dart';
import '../../utils/services/serive_post.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool usernamebutton = false;
  bool userpasswordbutton = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('登陆'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: width / 10, left: width / 10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _username,
                decoration: const InputDecoration(
                  // fillColor: Colors.blue.shade100,
                  filled: true,
                  labelText: '账号',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _password,
                decoration: const InputDecoration(
                  // fillColor: Colors.blue.shade100,
                  filled: true,
                  labelText: '密码',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: width / 2,
                height: 50,
                child: TextButton(
                    onPressed: loginbutton(context),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    child: const Text(
                      '登陆',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('没有账号？'),
                  Text(
                    '去注册',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  loginbutton(context) {
    return () async {
      var token = await Zibllpost.posttoken(
          username: _username.text, password: _password.text);
      if (token) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(
              '账号或密码输入错误,请重新输入',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )));
      }
    };
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }
}
