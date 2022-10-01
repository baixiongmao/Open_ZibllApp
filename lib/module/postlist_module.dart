//postlist to module
//     final postlist = postlistFromJson(jsonString);

import 'dart:convert';

List<Postlist> postlistFromJson(List<dynamic> str) =>
    List<Postlist>.from(str.map((x) => Postlist.fromJson(x)));

String postlistToJson(List<Postlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postlist {
  Postlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnail,
    required this.ziblldate,
    required this.zibllcategories,
    this.ziblltag,
    this.views,
    required this.ziblluser,
  });

  int id;
  Title title;
  int author;
  dynamic thumbnail;
  String ziblldate;
  List<Ziblllist> zibllcategories;
  dynamic ziblltag;
  String? views;
  Ziblluser ziblluser;

  factory Postlist.fromJson(Map<String, dynamic> json) => Postlist(
        id: json["id"],
        title: Title.fromJson(json["title"]),
        author: json["author"],
        thumbnail: json["thumbnail"] ?? '',
        ziblldate: json["ziblldate"],
        zibllcategories: List<Ziblllist>.from(
            json["zibllcategories"].map((x) => Ziblllist.fromJson(x))),
        ziblltag: json["ziblltag"],
        views: json["views"],
        ziblluser: Ziblluser.fromJson(json["ziblluser"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "author": author,
        "thumbnail": thumbnail,
        "ziblldate": ziblldate,
        "zibllcategories":
            List<dynamic>.from(zibllcategories.map((x) => x.toJson())),
        "ziblltag": ziblltag
            ? List<dynamic>.from(ziblltag.map((x) => x.toJson()))
            : false,
        "views": views,
        "ziblluser": ziblluser.toJson(),
      };
}

class Title {
  Title({
    required this.rendered,
  });

  String rendered;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}

class Ziblllist {
  Ziblllist({
    this.termId,
    this.name,
  });

  int? termId;
  String? name;

  factory Ziblllist.fromJson(Map<String, dynamic> json) => Ziblllist(
        termId: json["term_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "term_id": termId,
        "name": name,
      };
}

class Ziblluser {
  Ziblluser({
    required this.userid,
    required this.username,
    required this.useravatar,
    this.level,
  });

  int userid;
  String username;
  String useravatar;
  String? level;

  factory Ziblluser.fromJson(Map<String, dynamic> json) => Ziblluser(
        userid: json["userid"],
        username: json["username"],
        useravatar: json["useravatar"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "username": username,
        "useravatar": useravatar,
        "level": level,
      };
}
