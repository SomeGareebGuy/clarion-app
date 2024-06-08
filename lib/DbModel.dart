// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Accounts accountsFromJson(String str) => Accounts.fromJson(json.decode(str));

String accountsToJson(Accounts data) => json.encode(data.toJson());

class Accounts {

  ObjectId id;
  String email;
  String userName;
  String roll;

  Accounts({
    required this.id,
    required this.email,
    required this.userName,
    required this.roll,
  });

  factory Accounts.fromJson(Map<String, dynamic> json) => Accounts(
    id: json["id"],
    email: json["email"],
    userName: json["user_name"],
    roll: json["roll"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "user_name": userName,
    "roll": roll,
  };
}
