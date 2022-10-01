import 'package:flutter/material.dart';
import '../module/postlist_module.dart';

class ContentCard extends StatelessWidget {
  final Postlist item;
  final ScrollPhysics physics;
  const ContentCard({
    super.key,
    required this.item,
    required this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部图片
          Expanded(
            child: Center(
              child: SizedBox(
                height: 140,
                child: postimg(item.thumbnail),
              ),
            ),
          ),
          // 文章标题
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, right: 10, left: 10, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item.title.rendered,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      categories(context, item.zibllcategories),
                      tags(context, item.ziblltag),
                    ],
                  )),
                  Expanded(
                    child: Row(
                      children: [
                        // 头像
                        CircleAvatar(
                          radius: 10,
                          foregroundImage:
                              NetworkImage(item.ziblluser.useravatar),
                          onForegroundImageError: (exception, stackTrace) =>
                              const Icon(Icons.perm_identity),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // 时间
                        Text(
                          item.ziblldate,
                          style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                size: 15,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              Text(
                                item.views ?? '',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 11),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Image postimg(thumbnail) {
    if (thumbnail is bool) {
      return Image.asset(
        'assets/images/common/thumbnailerro.png',
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        thumbnail,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset('assets/images/common/thumbnailerro.png'),
      );
    }
  }

  Widget tags(context, tagstring) {
    if (tagstring is bool) {
      return const SizedBox();
    } else {
      List<Widget> tiles = [];
      for (var i = 0; i < tagstring.length; i++) {
        var categorieinfo = tagstring[i];
        tiles.add(Container(
          padding: const EdgeInsets.all(3),
          margin: const EdgeInsets.only(right: 3),
          color: Theme.of(context).colorScheme.background,
          child: Text(categorieinfo['name'] ?? '',
              style: const TextStyle(color: Color(0xFF888888))),
        ));
      }
      return Row(
        children: tiles,
      );
    }
    // return Text(tagstring.toString());
  }

  Widget categories(context, List<Ziblllist>? categorielist) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.only(right: 3),
      color: const Color(0x154489FF),
      child: Text(
        categorielist![0].name ?? '',
        style: const TextStyle(color: Color(0xFF448AFF)),
      ),
    );
  }
}
