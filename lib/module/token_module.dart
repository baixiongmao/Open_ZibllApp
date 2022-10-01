// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(Map<String, dynamic> str) => Token.fromJson(str);

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    required this.token,
    required this.userEmail,
    required this.userNicename,
    required this.userDisplayName,
  });

  String token;
  String userEmail;
  String userNicename;
  String userDisplayName;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        userEmail: json["user_email"],
        userNicename: json["user_nicename"],
        userDisplayName: json["user_display_name"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_email": userEmail,
        "user_nicename": userNicename,
        "user_display_name": userDisplayName,
      };
}
