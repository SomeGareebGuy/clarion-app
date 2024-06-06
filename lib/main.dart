import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/pages/ProfilePage.dart'; // Import HomePage
import 'package:untitled/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add Firebase Auth

final FirebaseAuth auth = FirebaseAuth.instance; // Create a global instance

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clarion App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _user != null ? const ProfilePage() : const LoginPage(),
    );
  }
}

