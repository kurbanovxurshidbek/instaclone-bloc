
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'log_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static bool isLoggedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static String currentUserId() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser!.uid;
  }

  static Future<User?> signInUser(
      BuildContext context, String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      LogService.i(user.toString());
      return user;
    } catch (e) {
      LogService.e(e.toString());
      return null;
    }
  }

  static Future<User?> signUpUser(
      BuildContext context, String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      LogService.i(user.toString());
      return user;
    } catch (e) {
      LogService.e(e.toString());
      return null;
    }
  }

  static Future<void> signOutUser() async {
    return _auth.signOut();
  }
}