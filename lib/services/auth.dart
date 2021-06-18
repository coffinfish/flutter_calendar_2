// @dart=2.9
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_calendar_2/models/theuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on user from firebase
  TheUser _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<TheUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User myUser = result.user;
      return _userFromFirebaseUser(myUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User myUser = result.user;
      return _userFromFirebaseUser(myUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User myUser = result.user;
      return _userFromFirebaseUser(myUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
