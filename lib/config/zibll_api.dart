//Zibll Api Url
class HttpOptions {
  // ignore: constant_identifier_names
  static const int CONNECT_TIMEOUT = 30000;
  // ignore: constant_identifier_names
  static const int RECEIVE_TIMEOUT = 30000;
  // ignore: constant_identifier_names
  static const String APPID = '__UNI__BCA1DCF';
  // ignore: constant_identifier_names
  static const String BASE_URL = 'https://www.bxmao.net';
  // ignore: constant_identifier_names
  static const String API_URL = '$BASE_URL/wp-json/wp/v2';
  static const String zibllPostToken = '$BASE_URL/wp-json/jwt-auth/v1/token';
  // ignore: constant_identifier_names
  static const String ZIBLLAPI_URL = '$BASE_URL/wp-json/zibllapi/v1';
  // ignore: constant_identifier_names
  static const String POSTAPI_URL = '$API_URL/posts';
  static const String userApiUrl = '$API_URL/users';
  static const String meInfoApiUrl = '$userApiUrl/me';
  static const String meInfoFields = 'id,name,userdata,useravatar';
  // ignore: constant_identifier_names
  static const String POSTLIST_FIELDS =
      'id,title.rendered,author,thumbnail,ziblldate,zibllcategories,ziblltag,views,ziblluser';
  // ignore: constant_identifier_names
  static const String POSINFO_FIELDS =
      'id,title.rendered,content,author,thumbnail,ziblldate,zibllcategories,ziblltag,views,like,ziblluser';
  static const String zibllCommentListApi = '$ZIBLLAPI_URL/commentlist';
  static const String zibllRelatedpostApi = '$ZIBLLAPI_URL/relatedpost';
  static const String zibllPostcomment = '$ZIBLLAPI_URL/postcomment';
}
