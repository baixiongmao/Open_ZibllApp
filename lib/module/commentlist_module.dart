//     final commentlist = commentlistFromJson(jsonString);

import 'dart:convert';

List<Commentlist> commentlistFromJson(List<dynamic> str) =>
    List<Commentlist>.from(str.map((x) => Commentlist.fromJson(x)));

String commentlistToJson(List<Commentlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commentlist {
  Commentlist({
    required this.commentid,
    required this.date,
    required this.userid,
    required this.username,
    required this.authorUrl,
    required this.content,
    this.child,
    this.replyname,
  });

  int commentid;
  String date;
  String userid;
  String username;
  String authorUrl;
  String content;
  List<Commentlist>? child;
  String? replyname;

  factory Commentlist.fromJson(Map<String, dynamic> json) => Commentlist(
        commentid: json["commentid"],
        date: json["date"],
        userid: json["userid"],
        username: json["username"],
        authorUrl: json["author_url"],
        content: json["content"],
        child: json["child"] == null
            ? null
            : List<Commentlist>.from(
                json["child"].map((x) => Commentlist.fromJson(x))),
        // ignore: prefer_if_null_operators
        replyname: json["Replyname"] == null ? null : json["Replyname"],
      );

  Map<String, dynamic> toJson() => {
        "commentid": commentid,
        "date": date,
        "userid": userid,
        "username": username,
        "author_url": authorUrl,
        "content": content,
        "child": child == null
            ? null
            : List<dynamic>.from(child!.map((x) => x.toJson())),
        // ignore: prefer_if_null_operators
        "Replyname": replyname == null ? null : replyname,
      };
}
