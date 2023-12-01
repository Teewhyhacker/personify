import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personify_app/models/usermodel.dart';
import 'package:personify_app/screen/home/home.dart';
import 'package:personify_app/screen/sharedscreen/LoadingPage.dart';
import 'package:personify_app/screen/sharedscreen/constants.dart';
import 'package:personify_app/services/database.dart';
import 'package:provider/provider.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String department = "";
  String content = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 25),
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
              child: Text(
            " ADD REPORTS",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
        ),
        loading
            ? SpinKitPulse(
                color: Colors.blue,
              )
            : Expanded(
                child: Form(
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
                                  hintText: "Enter your title"),
                              validator: (val) =>
                                  val!.isEmpty ? "Field Required" : null,
                              onChanged: (val) {
                                setState(() {
                                  title = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            // state form field
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Enter your Department"),
                              validator: (val) =>
                                  val!.isEmpty ? "Field Required" : null,
                              onChanged: (val) {
                                setState(() {
                                  department = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            // Country form field
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Enter your report"),
                              validator: (val) =>
                                  val!.isEmpty ? "Field required" : null,
                              onChanged: (val) {
                                content = val;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //  add reports button
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  await DatabaseService().AddReport(
                                      FirebaseAuth
                                          .instance.currentUser!.displayName,
                                      title,
                                      department,
                                      content);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => Home()));
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                              child: Text("ADD YOUR REPORT"),
                            ),

                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
