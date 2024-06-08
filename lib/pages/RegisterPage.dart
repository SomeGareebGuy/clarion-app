import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Register Page."),
        ElevatedButton(onPressed: auth.signOut, child:Text("Sign Out."))
      ],)));
  }
}
