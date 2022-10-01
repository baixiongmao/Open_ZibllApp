//     final relatedpostlist = relatedpostlistFromJson(jsonString);

import 'dart:convert';

List<Relatedpostlist> relatedpostlistFromJson(List<dynamic> str) =>
    List<Relatedpostlist>.from(str.map((x) => Relatedpostlist.fromJson(x)));

String relatedpostlistToJson(List<Relatedpostlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Relatedpostlist {
  Relatedpostlist({
    required this.postid,
    required this.title,
    required this.thumbnail,
    required this.date,
  });

  int postid;
  String title;
  String thumbnail;
  String date;

  factory Relatedpostlist.fromJson(Map<String, dynamic> json) =>
      Relatedpostlist(
        postid: json["postid"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "postid": postid,
        "title": title,
        "thumbnail": thumbnail,
        "date": date,
      };
}
