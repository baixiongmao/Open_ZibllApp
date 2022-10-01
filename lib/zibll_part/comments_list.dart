import 'package:flutter/material.dart';

import '../module/commentlist_module.dart';

class CommentCard extends StatelessWidget {
  final Commentlist commentinfo;
  final Function(int commentid) onTap;
  const CommentCard({
    Key? key,
    required this.commentinfo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 头像
        CircleAvatar(
          radius: 20,
          foregroundImage: NetworkImage(commentinfo.authorUrl),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 用户名
                          Text(
                            commentinfo.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            commentinfo.date,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.more_vert_rounded)
                ],
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () => onTap(commentinfo.commentid),
                child: Text(
                  commentinfo.content,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 10),
              commentcard(commentinfo.child, context)
            ],
          ),
        )
      ],
    );
  }

  commentcard(List<Commentlist>? childlist, context) {
    Iterable<Widget> childslistwidget = [];
    if (childlist != null) {
      childslistwidget = childlist.map((e) => child(e));
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: childslistwidget.toList(),
        ),
      );
    } else {
      return Column(
        children: childslistwidget.toList(),
      );
    }
  }

  Widget child(child) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 用户名
                Text(
                  "${child.username}回复${child.replyname}:${child.content}",
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
