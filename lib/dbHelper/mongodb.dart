import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:untitled/DbModel.dart';
import 'package:untitled/dbHelper/constant.dart';

import '../MongoDBHelper.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getQueryData(String fieldName, String value) async {
    final data = await userCollection.find(where.eq(fieldName, value)).toList();
    return data;
  }

  static Future<bool> checkUserRegistration(String fieldName, String value) async {
    // 1. Perform the MongoDB query
    final data = await userCollection.find(where.eq(fieldName, value)).toList();

    // 2. Check if any documents were found
    if (data.isEmpty) {
      return false; // User not found, likely not registered
    } else {
      return true;

    }
  }

  static Future<bool> checkUserRegistered(String fieldName, String value) async {
    final data = await userCollection.find(where.eq(fieldName, value)).toList();

    if (data[0].containsKey('userName') && data[0]['userName'] == null.toString()) {
      return true; // User found but not registered
    } else {
      return false;
    }
  }


  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something wrong while inserting Data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertIntoAccounts(Accounts data) async {
    try {
      var result = userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something wrong while inserting Data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}