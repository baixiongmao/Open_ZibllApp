import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import '../../module/postlist_module.dart';
import '../../utils/services/serive_get.dart';
import '../../zibll_part/content_card_part.dart';
import '../sub_page/post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late List<Postlist> postlist = [];
  int page = 1;
  late EasyRefreshController _easyRefreshController;
  bool nextpagebool = true;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    getpostlist(save: false);
  }

  Future<void> getpostlist({required bool save}) async {
    var newpage = save ? 1 : page;
    var list = await Zibllget.postlist(page: newpage);
    setState(() {
      if (save) {
        postlist = postlistFromJson(list);
        page += 1;
        _easyRefreshController.finishRefresh();
        _easyRefreshController.resetFooter();
      } else {
        var listlengt = postlistFromJson(list).length;
        if (listlengt < 10) {
          postlist.addAll(postlistFromJson(list));
          nextpagebool = false;
        } else {
          postlist.addAll(postlistFromJson(list));
          page += 1;
          nextpagebool = true;
        }
        _easyRefreshController.finishLoad(
            nextpagebool ? IndicatorResult.success : IndicatorResult.noMore);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title: const Image(
          image: NetworkImage(
              'https://www.bxmao.net/wp-content/uploads/2022/09/1592889141-pand_logo.webp'),
          height: 40,
          fit: BoxFit.fitHeight,
        ),
      ),
      body: contont(),
    );
  }

  Widget contont() {
    return EasyRefresh.builder(
      controller: _easyRefreshController,
      header: const ClassicHeader(
        processingText: '加载中',
        processedText: '加载完成',
        noMoreText: '没有更多了',
        showMessage: false,
      ),
      footer: const ClassicFooter(
        processingText: '加载中',
        processedText: '加载完成',
        noMoreText: '没有更多了',
        showMessage: false,
      ),
      onRefresh: () => getpostlist(save: true),
      onLoad: () => getpostlist(save: false),
      childBuilder: (BuildContext context, ScrollPhysics physics) {
        return ListView(
          // shrinkWrap: true,
          physics: physics,
          children: [
            SizedBox(
              height: 20,
            ),
            contontlist(physics: physics)
          ],
        );
      },
    );
  }

  Widget contontlist({physics}) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // 定义网格相关样式
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // 定义列
        crossAxisCount: 2,
        // 宽高比
        childAspectRatio: 0.75,
      ),
      itemCount: postlist.length,
      itemBuilder: (BuildContext context, int index) {
        var item = postlist[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostPage(
                          postid: item.id,
                        )));
          },
          child: ContentCard(
            item: item,
            physics: physics,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
//
}
