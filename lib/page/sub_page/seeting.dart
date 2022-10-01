import 'package:flutter/material.dart';

import '../../utils/db/sputil.dart';

class SeetingPage extends StatefulWidget {
  const SeetingPage({super.key});

  @override
  State<SeetingPage> createState() => _SeetingPageState();
}

class _SeetingPageState extends State<SeetingPage> {
  bool login = false;
  @override
  void initState() {
    super.initState();
    islogin();
  }

  void islogin() async {
    final istoken = await SPUtil.getString('usertoken');
    setState(() {
      if (istoken == null) {
        login = false;
      } else {
        login = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('设置'),
      ),
      body: ListView(
        children: [outbuttom()],
      ),
    );
  }

  Widget outbuttom() {
    if (login) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () {
              SPUtil.remove('usertoken');
              SPUtil.remove('myinfo');
            },
            child: const Text(
              '退出登陆',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
      );
    } else {
      return const Center(child: Text('欢迎使用'));
    }
  }
}
