import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/DbModel.dart';
import 'package:untitled/dbHelper/mongodb.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/insert.dart';
import 'package:untitled/pages/ProfilePage.dart';// Import HomePage
import 'package:untitled/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add Firebase Auth
import 'package:untitled/dbHelper/constant.dart';
import 'package:untitled/pages/RegisterPage.dart';
import 'package:untitled/query.dart';

import "package:mongo_dart/mongo_dart.dart" as M;

import 'display.dart';

final FirebaseAuth auth = FirebaseAuth.instance; // Create a global instance

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization
  await MongoDatabase.connect();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
        print(_user?.email);
      });
    });
  }

  checkUserRegistration() {
    final data = MongoDatabase.checkUserRegistration('email', (_user?.email).toString());
    return data;
  }

  checkUserRegistered() {
    final data = MongoDatabase.checkUserRegistered('email', (_user?.email).toString());
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clarion App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _user != null ?  FutureBuilder(future: checkUserRegistration(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error checking registration'));
          } else {
            var isRegistered = checkUserRegistration();
            if (isRegistered == true) {
              return const ProfilePage();
            } else {
              isRegistered = checkUserRegistered();

              if (isRegistered == true) {
                var _id = M.ObjectId();
                final data = Accounts(id: _id, email: (_user?.email).toString(), userName: null.toString(), roll: null.toString());
                var result = MongoDatabase.insertIntoAccounts(data);
              }
              return const Registerpage();
            }
          }
        },) : const LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/profile': (context) => ProfilePage(),
        '/register': (context) => Registerpage(),
        // ... Add more routes for other pages
      },
    );
  }
}


