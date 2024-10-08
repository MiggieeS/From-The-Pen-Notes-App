import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;

  static Stream<User?> get userStream => _auth.userChanges();

  //register the user using email and password.
  static Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(); //send email verification after registering
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  // Login user
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!_auth.currentUser!.emailVerified) {
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Email not verified. Please verify your email first.',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  //sends a reset password email.
  static Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  //sends verification in email
  static Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  //changes the current password to new password.
  static Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    User? user = _auth.currentUser;

    if (user != null) {
      //reauthenticate.
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      try {
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        throw e;
      } catch (e) {
        throw e;
      }
    } else {
      throw Exception('No user is currently logged in.');
    }
  }
}
