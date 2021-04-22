import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/sANJAI%20R/Documents/GitHub/competitive/grubhub/lib/Components/textwidget.dart';
class Dashboard extends StatefulWidget {
  final UserCredential user;
  Dashboard({Key key,this.user}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: ' you logged in as ${widget.user.user.email}',size: 10,),
      ),
    );
  }
}
