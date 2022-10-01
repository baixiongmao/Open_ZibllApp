import 'package:flutter/material.dart';

import '../module/relatedpostlist_module.dart';

class RelatedPostCard extends StatelessWidget {
  final Relatedpostlist relatedpostinfo;
  const RelatedPostCard({super.key, required this.relatedpostinfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              relatedpostinfo.thumbnail,
              width: 150,
              height: 80,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/common/thumbnailerro.png',
                width: 150,
                height: 80,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      relatedpostinfo.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        relatedpostinfo.date,
                        style: TextStyle(
                            fontSize: 13,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ))
                ],
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
