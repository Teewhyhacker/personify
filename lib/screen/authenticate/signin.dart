import 'package:flutter/material.dart';
import 'package:personify_app/screen/authenticate/signup.dart';
import 'package:personify_app/screen/home/home.dart';
import 'package:personify_app/screen/sharedscreen/LoadingPage.dart';
import 'package:personify_app/services/AuthService.dart';

class SignIn extends StatefulWidget {
  SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String error = "";
  bool loading = false;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text("Sign in to Personify"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => SignUp()));
                  },
                  child: Row(
                    children: [Icon(Icons.person), Text("Sign Up")],
                  ),
                )
              ],
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithGoogle();
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = "could not sign in, try again please";
                          });
                        } else {
                          print("Signed in");
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (builder) => Home()));
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Text("sign in with google"),
                    ),

                    // facebook button
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithFacebook();
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = "could not sign in, try again please";
                          });
                        } else {
                          print("Signed in");

                          setState(() {
                            loading = false;
                          });
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (builder) => Home()));
                        }
                      },
                      child: Text("sign in with facebook"),
                    ),

                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
