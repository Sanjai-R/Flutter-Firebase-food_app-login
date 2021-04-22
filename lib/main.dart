import 'package:flutter/material.dart';
import 'package:grubhub/Views/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SigninPage(),
    );
  }
}

