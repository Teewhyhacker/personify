import 'package:flutter/material.dart';
import 'package:personify_app/firebase_options.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:personify_app/models/usermodel.dart';
import 'package:personify_app/screen/sharedscreen/ErrorPage.dart';
import 'package:personify_app/screen/sharedscreen/LoadingPage.dart';
import 'package:personify_app/screen/wrapper/Wrapper.dart';
import 'package:personify_app/services/AuthService.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      initialData: UserModel(),
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return ErrorPage();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Wrapper();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return LoadingPage();
          },
        ),
      ),
    );
  }
}
