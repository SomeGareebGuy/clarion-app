import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget image() {
    return Center(child: SizedBox (
      height: 371,
      child: Image.asset('assets/images/login.png')
    ),
    );
  }

  Widget signInText() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.left,
            'Sign Up / Sign In'
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18.0,
              color: Colors.black,
          ),
              textAlign: TextAlign.left,
              'To record your debates.'
          ),
        ),
      ]
    );
  }

  Widget termsText() {
    return Column(
      children: [
        SizedBox(
          child: Text(style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 12.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
          'I accept App’s Terms of User and Privacy Policy.'
          ),
        ),
        SizedBox(height: 5),
      ]
    );
  }

  Widget googleSignInButton() {
    return Center(child: SizedBox (
      height: 50,
      child: FilledButton(
        onPressed: _handleGoogleSignIn,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0), // Change corner radius here
              side: BorderSide(color: Colors.black, width: 1.0), // Add stroke here
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(MediaQuery.of(context).size.width * 0.9, 40.0), // Set width based on screen width
          ),
        ),
        child: Text(style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.0,
            color: Colors.white,
            ),
          'Continue with Google'),
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Column(
        children: [
          Expanded( // Wrap everything except termsText
            child: Column( // Inner column for centered elements
              mainAxisAlignment: MainAxisAlignment.center, // Center items
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                image(),
                SizedBox(height: 24.0),
                signInText(),
                SizedBox(height: 34.0),
                googleSignInButton(),
              ],
            ),
          ),
          termsText(), // Placed at the bottom
        ],
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      auth.signInWithProvider(googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }
}

