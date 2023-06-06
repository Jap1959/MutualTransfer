import 'package:connect2prof/pages/ResetPasword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Registration error: $e');
      if(e.toString()=='[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        Get.snackbar(
          "Error", "Email already in use",
          icon: Icon(Icons.close, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
      else{
        Get.snackbar(
          "Error", "Some Error occured try again",
          icon: Icon(Icons.close, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
      return null;
    }
  }

  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'true';
    } on FirebaseAuthException catch (e) {
      print('Firebase Authentication Exception: ${e.code} - ${e.message}');
      // Handle specific authentication error codes
      return e.code;
    } catch (e) {
      print('Unknown error: $e');
      // Handle other unknown exceptions
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
  Future<String> resetPassword({required String email}) async {
    print(email);
    String _Status='false';
    await _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .then((value) => _Status='true')
        .catchError((e) {
      return _Status;
    });
    return _Status;
  }
}
