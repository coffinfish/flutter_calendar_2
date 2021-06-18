// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_calendar_2/models/theuser.dart';
import 'package:flutter_calendar_2/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_calendar_2/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_2/ui/pages/add_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple[300],
          // ignore: deprecated_member_use
          accentColor: Colors.deepPurple[100],
        ),
        home: Wrapper(),
        routes: {
          "add_event": (_) => AddEventPage(),
        },
      ),
    );
  }
}
