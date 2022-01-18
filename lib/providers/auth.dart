import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Sign in if account exists
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        notifyListeners();
      } else {
        rethrow;
      }
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    {
      try {
        await _auth.signOut();
      } catch (e) {
        print(e);
      }
    }
  }
}
