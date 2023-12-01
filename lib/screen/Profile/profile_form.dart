import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personify_app/models/usermodel.dart';
import 'package:personify_app/screen/sharedscreen/LoadingPage.dart';
import 'package:personify_app/screen/sharedscreen/constants.dart';
import 'package:personify_app/services/AuthService.dart';
import 'package:personify_app/services/database.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> Gender = ["Enter your gender", "Male", "Female"];
  bool loading = false;
  String _email = "";
  String currentUserName = "";
  int currentAge = 18;
  String currentState = "";
  String currentCountry = "";
  String? currentGender = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return loading
        ? Container(child: SpinKitFadingCircle(
          color: Colors.blue,
        ))
        : Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    Text(
                      "Update your Profile Data",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: "Edit your User Name"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter a user name" : null,
                      onChanged: (val) {
                        setState(() {
                          currentUserName = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                          currentAge = int.parse(val);
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
                          currentState = val;
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
                        currentCountry = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Gender Dropdown
                    DropdownButtonFormField(
                      value: Gender[0],
                      decoration: textInputDecoration.copyWith(
                          hintText: "gender"),
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
                    // LogOut button
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          await DatabaseService(uid: user.uid)
                              .updateUserDataProfile(
                                  currentUserName,
                                  currentAge,
                                  currentState,
                                  currentCountry,
                                  currentGender);
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Text("Update your profile"),
                    ),
                  ],
                ),
              ],
            ));
  }
}
