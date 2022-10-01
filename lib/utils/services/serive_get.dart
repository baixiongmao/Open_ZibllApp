import 'dart:convert';

import '../../config/zibll_api.dart';
import '../db/sputil.dart';
import '../http/http.dart';

class Zibllget {
  static Future postlist({required int page}) async {
    final httplist = await Http.get(
      HttpOptions.POSTAPI_URL,
      params: {
        'page': page,
        '_fields': HttpOptions.POSTLIST_FIELDS,
      },
    );
    if (httplist['code'] == 200) {
      return httplist['data'];
    } else {
      return [];
    }
  }

  static Future postinfo({required int postid}) async {
    final httplist = await Http.get(
      '${HttpOptions.POSTAPI_URL}/$postid',
      params: {
        '_fields': HttpOptions.POSINFO_FIELDS,
      },
    );
    if (httplist['code'] == 200) {
      return httplist['data'];
    } else {
      return [];
    }
  }

  static Future commentlist(
      {required int postid, int? limit, required int page}) async {
    final httplist = await Http.get(
      HttpOptions.zibllCommentListApi,
      // postid=7033&limit=10&page=1
      params: {
        'postid': postid,
        'limit': limit ?? '10',
        'page': page,
      },
    );
    if (httplist['code'] == 200) {
      return httplist['data'];
    } else {
      return [];
    }
  }

  static Future relatedpostlist({required int postid}) async {
    final httplist = await Http.get(
      HttpOptions.zibllRelatedpostApi,
      params: {'postid': postid},
    );
    if (httplist['code'] == 200) {
      return httplist['data'];
    } else {
      return [];
    }
  }

  static Future myinfo() async {
    final token = await SPUtil.getString('usertoken');
    Http.setHeaders({'Authorization': 'Bearer$token'});
    final httplist = await Http.get(
      HttpOptions.meInfoApiUrl,
      params: {
        '_fields': HttpOptions.meInfoFields,
      },
    );
    if (httplist['code'] == 200) {
      String savemyinfo = json.encode(httplist['data']);
      await SPUtil.save('myinfo', savemyinfo);
      return httplist['data'];
    } else {
      return [];
    }
  }
}
