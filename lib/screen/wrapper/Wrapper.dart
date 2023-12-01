import 'package:flutter/material.dart';
import 'package:personify_app/models/usermodel.dart';
import 'package:personify_app/screen/authenticate/authenticate.dart';
import 'package:personify_app/screen/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    print(user.uid);
    if (user.uid == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
