


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication{

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }


  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if( googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exist-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content:  'account-exist-with-different-credential',
            ),
          );

        } else if (e.code == 'invalid-crendential') {

          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content:  'invalid-crendential',
            ),
          );
        }
      }catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content:  'Login Failed',
          ),
        );

      }
      }
      return user;
    }

}

