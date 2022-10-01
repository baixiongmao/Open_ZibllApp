//     final myinfo = myinfoFromJson(jsonString);

import 'dart:convert';

Myinfo myinfoFromJson(Map<String, dynamic> str) => Myinfo.fromJson(str);

String myinfoToJson(Myinfo data) => json.encode(data.toJson());

class Myinfo {
  Myinfo({
    required this.id,
    required this.name,
    required this.userdata,
    required this.useravatar,
  });

  int id;
  String name;
  Userdata userdata;
  String useravatar;

  factory Myinfo.fromJson(Map<String, dynamic> json) => Myinfo(
        id: json["id"],
        name: json["name"],
        userdata: Userdata.fromJson(json["userdata"]),
        useravatar: json["useravatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userdata": userdata.toJson(),
        "useravatar": useravatar,
      };
}

class Userdata {
  Userdata({
    required this.posts,
    required this.comments,
    required this.favorite,
  });

  int posts;
  int comments;
  int favorite;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        posts: json["posts"],
        comments: json["comments"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "posts": posts,
        "comments": comments,
        "favorite": favorite,
      };
}
