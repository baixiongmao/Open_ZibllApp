// To parse this JSON data, do
//
//     final postinfo = postinfoFromJson(jsonString);

import 'dart:convert';

Postinfo postinfoFromJson(Map<String, dynamic> str) => Postinfo.fromJson(str);

String postinfoToJson(Postinfo data) => json.encode(data.toJson());

class Postinfo {
  Postinfo({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.thumbnail,
    required this.ziblldate,
    required this.zibllcategories,
    this.ziblltag,
    required this.views,
    required this.like,
    required this.ziblluser,
  });

  int id;
  Title title;
  Content content;
  int author;
  dynamic thumbnail;
  String ziblldate;
  List<Zibll> zibllcategories;
  dynamic ziblltag;
  String views;
  String like;
  Ziblluser ziblluser;

  factory Postinfo.fromJson(Map<String, dynamic> json) => Postinfo(
        id: json["id"],
        title: Title.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        author: json["author"],
        thumbnail: json["thumbnail"],
        ziblldate: json["ziblldate"],
        zibllcategories: List<Zibll>.from(
            json["zibllcategories"].map((x) => Zibll.fromJson(x))),
        ziblltag: json["ziblltag"],
        views: json["views"],
        like: json["like"],
        ziblluser: Ziblluser.fromJson(json["ziblluser"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "content": content.toJson(),
        "author": author,
        "thumbnail": thumbnail,
        "ziblldate": ziblldate,
        "zibllcategories":
            List<dynamic>.from(zibllcategories.map((x) => x.toJson())),
        "ziblltag": List<dynamic>.from(ziblltag.map((x) => x.toJson())),
        "views": views,
        "like": like,
        "ziblluser": ziblluser.toJson(),
      };
}

class Content {
  Content({
    required this.rendered,
    required this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
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

class Zibll {
  Zibll({
    required this.termId,
    required this.name,
  });

  int termId;
  String name;

  factory Zibll.fromJson(Map<String, dynamic> json) => Zibll(
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
    required this.level,
  });

  int userid;
  String username;
  String useravatar;
  String level;

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
