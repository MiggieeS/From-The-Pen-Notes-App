import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email = '';
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  Future<void> authenticateWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Sends the email verification
      await userCredential.user?.sendEmailVerification();

      await _auth.signOut();

      throw FirebaseAuthException(
        code: 'email-verification-sent',
        message: 'A verification email has been sent. Please verify before logging in.',
      );
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }
}
