import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
          child: SpinKitDancingSquare(
        size: 50,
        color: Colors.blue,
      )),
    );
  }
}
