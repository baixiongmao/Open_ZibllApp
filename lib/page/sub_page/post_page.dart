import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getwidget/getwidget.dart';

import '../../module/commentlist_module.dart';
import '../../module/postinfo_module.dart';
import '../../module/relatedpostlist_module.dart';
import '../../utils/db/sputil.dart';
import '../../utils/services/serive_get.dart';
import '../../utils/services/serive_post.dart';
import '../../zibll_part/comments_list.dart';
import '../../zibll_part/relatedpost.dart';
import 'login.dart';

class PostPage extends StatefulWidget {
  final int postid;
  const PostPage({super.key, required this.postid});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // 输入框
  final TextEditingController _textEditingController = TextEditingController();
  late Postinfo postinfo;
  late List<Commentlist> _commentlist = [];
  late List<Relatedpostlist> _relatedpostlist = [];
  int page = 1;
  late EasyRefreshController _easyRefreshController;
  bool postshow = true;
  bool nextpage = true;
  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    getpostinfo();
    getrelatedpostlist();
  }

  Future<void> getpostinfo() async {
    var zibllpostinfo = await Zibllget.postinfo(postid: widget.postid);
    setState(() {
      postinfo = postinfoFromJson(zibllpostinfo);
      postshow = false;
    });
  }

  Future getcommentlist() async {
    var jsonString =
        await Zibllget.commentlist(postid: widget.postid, page: page);
    setState(() {
      var jsonCommentlist = commentlistFromJson(jsonString['data']);
      if (jsonCommentlist.length < 10) {
        _commentlist.addAll(jsonCommentlist);
        _easyRefreshController.finishLoad(IndicatorResult.noMore);
      } else {
        _commentlist.addAll(jsonCommentlist);
        page += 1;
        _easyRefreshController.finishLoad(IndicatorResult.noMore);
      }
    });
  }

  Future onRefresh() async {
    var jsonString = await Zibllget.commentlist(postid: widget.postid, page: 1);
    setState(() {
      var jsonCommentlist = commentlistFromJson(jsonString['data']);
      if (jsonCommentlist.length < 10) {
        _commentlist = jsonCommentlist;
        _easyRefreshController.finishLoad(IndicatorResult.noMore);
      } else {
        _commentlist = jsonCommentlist;
        page = 2;
        _easyRefreshController.finishLoad(IndicatorResult.noMore);
      }
    });
  }

  Future getrelatedpostlist() async {
    var jsonString = await Zibllget.relatedpostlist(
      postid: widget.postid,
    );
    setState(() {
      _relatedpostlist = relatedpostlistFromJson(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          '详情',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_sharp),
            onPressed: () {},
          )
        ],
      ),
      body: ezloadingbody(context),
      bottomNavigationBar: postbutton(context),
    );
  }

  Widget ezloadingbody(context) {
    if (postshow) {
      return const Center(
        child: GFLoader(type: GFLoaderType.ios),
      );
    } else {
      return EasyRefresh(
        controller: _easyRefreshController,
        footer: const ClassicFooter(
          processingText: '加载中',
          processedText: '加载完成',
          noMoreText: '没有更多了',
          showMessage: false,
        ),
        onLoad: () => getcommentlist(),
        child: ListView(
          shrinkWrap: true,
          children: [
            postcontent(),
            postrecommend(),
            postdiscuss(context),
          ],
        ),
      );
    }
  }

  Widget postcontent() {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            postinfo.title.rendered,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // 头像
              CircleAvatar(
                radius: 20,
                foregroundImage: NetworkImage(postinfo.ziblluser.useravatar),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postinfo.ziblluser.username,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 15),
                    ),
                    Text(
                      postinfo.ziblldate,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 11),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(50, 40)),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: MaterialStateProperty.all(Colors.pink)),
                  onPressed: () {
                    getpostinfo();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    '关注',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          const SizedBox(height: 10),
          Html(data: postinfo.content.rendered),
          // 标签
          Wrap(
            spacing: 3,
            children: categorieslist(),
          ),
          Wrap(
            spacing: 3,
            children: tags(),
          )
          //
        ]),
      ),
    );
  }

  List<Widget> categorieslist() {
    var categories = postinfo.zibllcategories.map((e) => RawChip(
        deleteIconColor: Theme.of(context).colorScheme.shadow,
        label: Text(e.name)));
    return categories.toList();
  }

  List<Widget> tags() {
    var taglist = postinfo.ziblltag;
    if (taglist is bool) {
      return [];
    } else {
      var tagfroJson =
          List<Zibll>.from(postinfo.ziblltag.map((x) => Zibll.fromJson(x)));
      var taglist = tagfroJson.map((e) => RawChip(
          deleteIconColor: Theme.of(context).colorScheme.shadow,
          label: Text(e.name)));
      return taglist.toList();
    }
  }

  Widget postrecommend() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: relatedpostlist(),
        ),
      ),
    );
  }

  Widget postdiscuss(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            const ListTile(
              leading: Text(
                '评论',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            postdiscusscard(context)
          ],
        ),
      ),
    );
  }

  Widget postdiscusscard(context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _commentlist.length,
        itemBuilder: (context, index) => CommentCard(
              commentinfo: _commentlist[index],
              onTap: (commentid) => _clickSpec(context, commentid: commentid),
            ));
  }

  Widget postbutton(context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border(
              top: BorderSide(
                  width: 0.5, color: Theme.of(context).colorScheme.outline))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                _clickSpec(context, commentid: 0);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                height: 35,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background, //设置背景颜色
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: const Center(child: Text('留下你的宝贵意见')),
              ),
            )),
            const SizedBox(width: 5),
            const Icon(Icons.star_border_rounded),
            const SizedBox(width: 5),
            const Icon(Icons.thumb_up_off_alt),
            const SizedBox(width: 5),
            const Icon(Icons.ios_share),
          ],
        ),
      ),
    );
  }

  // 底部弹窗
  void _clickSpec(context, {required int commentid}) async {
    var myinfo = await SPUtil.getString('usertoken');
    if (myinfo == null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
      return;
    }
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                right: 10,
                left: 10,
                top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('发表评论'),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 10,
                  minLines: 3,
                  autofocus: true,
                  controller: _textEditingController,
                  // 光标颜色
                  // 输入框样式
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.background,
                    filled: true,
                    hintText: '我有话要说',
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.only(left: 5, bottom: 10),
                    border: OutlineInputBorder(
                      //添加边框
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // 文字样式
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  onEditingComplete: () {
                    // 发送
                    // postsearch(_textEditingController.text);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(60, 30)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          postcomment(commentid);
                        },
                        child: const Text(
                          '发送',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> relatedpostlist() {
    final List<Widget> relatedpostwidgetlist = [
      const ListTile(
        leading: Text(
          '相关推荐',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    ];
    for (var i = 0; i < _relatedpostlist.length; i++) {
      var relatedpostinfo = _relatedpostlist[i];
      relatedpostwidgetlist.add(InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostPage(
                        postid: relatedpostinfo.postid,
                      )));
        },
        child: RelatedPostCard(
          relatedpostinfo: relatedpostinfo,
        ),
      ));
    }
    return relatedpostwidgetlist;
  }

  void postcomment(commentid) async {
    var callback = await Zibllpost.postcomment(
      comment: _textEditingController.text,
      commentid: commentid,
      postid: widget.postid,
    );
    setState(() {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        callback['msg'],
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      )));
      if (callback['code'] == 1) {
        _textEditingController.text = '';
      }
      onRefresh();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _easyRefreshController.dispose();
    super.dispose();
  }
}
