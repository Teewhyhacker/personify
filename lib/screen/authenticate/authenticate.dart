import 'package:flutter/material.dart';
import 'package:personify_app/screen/authenticate/signin.dart';
import 'package:personify_app/screen/authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    bool showSignIn = true;
    print(showSignIn);
    toggleView() {
      setState(() {
        showSignIn = !showSignIn;
      });
      print(showSignIn);
    }

    return SignUp();
  }
}
