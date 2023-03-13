import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

  Future<UserCredential> signInWithGoogle(Function function) async {
    // begin interactive signIn process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //
    final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken, accessToken: gAuth.accessToken);

    function();

    // sign in with firebase
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook(Function function) async {
    // begin interactive signIn process
    final loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);
    final userData = await FacebookAuth.instance.getUserData();

    // obtain auth details from request
    final credentials =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    function();
    // sign in with firebase
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }
}
