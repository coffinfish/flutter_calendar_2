// @dart=2.9
import "package:flutter/material.dart";
import 'package:flutter_calendar_2/screens/authenticate/authenticate.dart';
import 'package:flutter_calendar_2/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_2/models/theuser.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home or authenticate widget
    final myuser = Provider.of<TheUser>(context);
    if (myuser == null) {
      print("hi");
      return Authenticate();
    } else {
      print("bye");
      return Home();
    }
  }
}
