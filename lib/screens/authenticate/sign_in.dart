// @dart=2.9
import "package:flutter/material.dart";
import 'package:flutter_calendar_2/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKeyA = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        elevation: 0.0,
        title: Text("Sign In to Flutter Calendar"),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKeyA,
          child: Column(children: <Widget>[
            SizedBox(height: 20.0),
// EMAIL FIELD
            TextFormField(
              style: TextStyle(color: Colors.deepPurple[400]),
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
              decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.deepPurple[400],
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple[400], width: 2))),
              cursorColor: Colors.deepPurple[400],
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0),
// PASSWORD FIELD
            TextFormField(
              style: TextStyle(color: Colors.deepPurple[400]),
              validator: (val) => val.length < 8
                  ? 'Password must be atleast 8 characters long'
                  : null,
              decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.deepPurple[400],
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple[400], width: 2))),
              cursorColor: Colors.deepPurple[400],
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple[400])),
              child: Text("Sign In", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if (_formKeyA.currentState.validate()) {
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() => error = "Invalid Email or Password");
                  }
                }
              },
            ),
            SizedBox(height: 20.0),
            Text(
              error,
              style: TextStyle(
                color: Colors.red[200],
                fontSize: 14.0,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
