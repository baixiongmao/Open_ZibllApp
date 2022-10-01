import 'dart:convert';
import '../../config/zibll_api.dart';
import '../../module/myinfo_module.dart';
import '../../module/token_module.dart';
import '../db/sputil.dart';
import '../http/http.dart';

class Zibllpost {
  static Future postcomment(
      {required int postid,
      required int commentid,
      required String comment}) async {
    var myinfostring = await SPUtil.getString('myinfo');
    var myinfo = myinfoFromJson(json.decode(myinfostring!));
    var userid = myinfo.id;
    final token = await SPUtil.getString('usertoken');
    Http.setHeaders({'Authorization': 'Bearer$token'});
    final postlist = await Http.post(
      HttpOptions.zibllPostcomment,
      data: {
        'userid': userid,
        'comment': comment,
        'postid': postid,
        'commentid': commentid,
      },
    );
    if (postlist['code'] == 200) {
      return postlist['data'];
    } else {
      return [];
    }
  }

  static Future<bool> posttoken(
      {required String username, required String password}) async {
    final postlist = await Http.post(HttpOptions.zibllPostToken,
        data: {'username': username, 'password': password});

    if (postlist['code'] == 200) {
      final userinfo = tokenFromJson(postlist['data']);
      await SPUtil.save('usertoken', userinfo.token);
      await SPUtil.getString('usertoken');
      return true;
    } else {
      return false;
    }
  }
}
