import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personify_app/screen/authenticate/signin.dart';
import 'package:personify_app/screen/sharedscreen/LoadingPage.dart';
import 'package:personify_app/screen/sharedscreen/constants.dart';
import 'package:personify_app/services/AuthService.dart';
import 'package:personify_app/services/database.dart';

class SignUp extends StatefulWidget {
  SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
// text field state

  String error = "";
  bool loading = false;
  String email = "";
  String userName = "";
  int age = 18;
  String state = "";
  String country = "";
  String gender = "";
  final List<String> Gender = ["Enter your gender","Male", "Female"];
  String? currentGender = "";
  // obj fior AuthService
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text("Sign up to Personify"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => SignIn()));
                  },
                  child: Row(
                    children: [Icon(Icons.person), Text("Sign In")],
                  ),
                )
              ],
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // userName form field
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Enter your User Name"),
                          validator: (val) =>
                              val!.isEmpty ? "Enter a user name" : null,
                          onChanged: (val) {
                            setState(() {
                              userName = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // age form field
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Enter your age"),
                          validator: (val) =>
                              val!.length < 0 && val!.length > 2 || val!.isEmpty
                                  ? "input your right age"
                                  : null,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              age = int.parse(val);
                            });
                          },
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // state form field
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Enter your state"),
                          validator: (val) =>
                              val!.isEmpty ? "Enter your state" : null,
                          onChanged: (val) {
                            setState(() {
                              state = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // Country form field
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Enter your country"),
                          validator: (val) =>
                              val!.isEmpty ? "Enter your country" : null,
                          onChanged: (val) {
                            country = val;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // Gender form Field
                        // Gender Dropdown
                        DropdownButtonFormField(
                          value: Gender[0],
                          decoration: textInputDecoration.copyWith(
                              hintText: "enter your gender"),
                          items: Gender.map((gender) {
                            return DropdownMenuItem(
                              child: Text("$gender"),
                              value: gender,
                            );
                          }).toList(),
                          onChanged: (val) {
                            currentGender = val;
                          },
                          validator: (val) =>
                              val!.startsWith("E") ? "select a gender" : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // google button
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.signUpWithGoogle();
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = "could not sign in, try again please";
                                });
                              } else {
                                print("Signed in");
                              }
                              await DatabaseService(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .updateUserData(
                                      FirebaseAuth.instance.currentUser!.email
                                          .toString(),
                                      userName,
                                      age,
                                      state,
                                      country,
                                      gender);
                            } else {}
                          },
                          child: Text("sign up with google"),
                        ),

                        // facebook button
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.signInWithFacebook();
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = "could not sign in, try again please";
                                });
                              } else {}
                            } else {
                              print("Signed in");
                            }
                            await DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .updateUserData(
                                    FirebaseAuth.instance.currentUser!.email
                                        .toString(),
                                    userName,
                                    age,
                                    state,
                                    country,
                                    gender);
                          },
                          child: Text("sign up with facebook"),
                        ),

                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
