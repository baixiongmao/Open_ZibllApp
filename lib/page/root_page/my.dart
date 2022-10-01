import 'dart:convert';
import 'package:flutter/material.dart';

import '../../module/myinfo_module.dart';
import '../../utils/db/sputil.dart';
import '../../utils/services/serive_get.dart';
import '../sub_page/login.dart';
import '../sub_page/seeting.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Myinfo _myinfo;
  bool mypageshow = false;

  @override
  void initState() {
    super.initState();
    _spgetmyinfo();
  }

  _spgetmyinfo() async {
    var myinfostring = await SPUtil.getString('myinfo');
    setState(() {
      if (myinfostring != null) {
        _myinfo = myinfoFromJson(json.decode(myinfostring));
        mypageshow = true;
      }
    });
  }

  _getRequests() async {
    var token = await SPUtil.getString('usertoken');
    if (token == null) {
      return;
    }
    var getmeinfo = await Zibllget.myinfo();
    setState(() {
      if (getmeinfo == null) {
        return;
      } else {
        _myinfo = myinfoFromJson(getmeinfo);
        mypageshow = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(builder: (_) => const SeetingPage()),
                  )
                  .then((val) => val is bool ? _getRequests() : null);
            },
          )
        ],
      ),
      body: Column(
        children: [mypageshow ? userinfo() : nologin(), userinfocard()],
      ),
    );
  }

  Widget nologin() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            )
            .then((val) => val is bool ? _getRequests() : null);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            foregroundImage: const AssetImage(
                'https://oss.zibll.com/zibll.com/2021/12/8FB3BAFB-9DD7-4507-9DBF-2DD773D0FB2D.png'),
            onForegroundImageError: (exception, stackTrace) =>
                const Icon(Icons.perm_identity),
          ),
          const SizedBox(height: 20),
          const Text(
            '点击登陆',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget userinfo() {
    return Column(
      children: [
        InkWell(
          child: CircleAvatar(
            radius: 40,
            foregroundImage: NetworkImage(_myinfo.useravatar),
            onForegroundImageError: (exception, stackTrace) =>
                const Icon(Icons.perm_identity),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _myinfo.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        )
      ],
    );
  }

  Widget userinfocard() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mypageshow ? _myinfo.userdata.posts.toString() : '0',
                style: const TextStyle(fontSize: 25),
              ),
              Text('文章')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mypageshow ? _myinfo.userdata.comments.toString() : '0',
                style: const TextStyle(fontSize: 25),
              ),
              const Text('评论')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mypageshow ? _myinfo.userdata.favorite.toString() : '0',
                style: const TextStyle(fontSize: 25),
              ),
              const Text('收藏')
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
