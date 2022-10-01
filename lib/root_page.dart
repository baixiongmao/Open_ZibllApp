import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/root_page/home.dart';
import 'page/root_page/my.dart';
import 'utils/db/sputil.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

// 底部按钮数组
const Map<String, String> _bottonNames = {'home': '首页', 'my': '我的'};

class _RootPageState extends State<RootPage> {
  //  默认选中索引
  int _currentIndex = 0;
  //第1步，声明PageController
  late PageController _pageController;
  final List<Widget> _pages = [
    const HomePage(),
    const MyPage(),
    // Text('data')
    // 页面集合
  ];
  final List<BottomNavigationBarItem> _boottomNavBarList = [];
  // 页面初始化
  @override
  void initState() {
    super.initState();
    spdb();
    _pageController = PageController(initialPage: _currentIndex);
    //第2步，初始化PageController
    // 循环获取底部按钮信息
    _bottonNames.forEach((key, value) {
      _boottomNavBarList.add(_bottomNavBatItem(key, value));
    });
  }

  Future spdb() async {
    await SPUtil.init();
  }

  @override
  Widget build(BuildContext context) {
    // 沉浸模式
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
      ),
      // 底部导航按钮
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        fixedColor: Theme.of(context).colorScheme.onPrimaryContainer,
        items: _boottomNavBarList,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // 底部点击方法
  void _onTabClick(int index) {
    setState(() {
      // 赋值点击id
      _currentIndex = index;
      _pageController.jumpToPage(_currentIndex);
    });
  }

  // 底部导航按钮
  BottomNavigationBarItem _bottomNavBatItem(String key, String value) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/icons/bottom/$key.png',
          width: 24,
          height: 24,
        ),
        label: value);
  }
}
