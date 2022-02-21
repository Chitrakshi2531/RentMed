


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/authentication/otp_screen.dart';
import 'package:med_rent/userApp/view/home_Screen.dart';

class PhoneAuthServices{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser(BuildContext context,uid) async {

      final QuerySnapshot result = await users.where('uid',isEqualTo: uid).get();

      List <DocumentSnapshot> document = result.docs;

        if(document.length > 0){
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
        }
        else{
          return users.doc(user!.uid).set({
            'uid': user!.uid,
            'mobile': user!.phoneNumber,
            'email': user!.email,
          })
              .then((value) {
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
          })

              .catchError((error) => print('Failed to add user: $error'));
        }
    }

    Future<void> verifyPhoneNumber(BuildContext context,number) async {
      final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      };

      final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
        if(e.code == 'invalid-phone-number') {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('invalid phone number',
              style: TextStyle(fontSize: 15,)),
            )
          );
        }
        print('The errors is ${e.code}');
      };

      final PhoneCodeSent codeSent = (String verId , int? resendToken) async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTPScreen(number: number,verId: verId),),);
      };

      try{
        auth.verifyPhoneNumber(
            phoneNumber: number,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            timeout: const Duration(seconds: 20),
            codeAutoRetrievalTimeout: (String verificationId){
            print(verificationId);
            });
      }catch(e)
      {
        print('Error ${e.toString()}');
      }
    }

    showAlertDialog(BuildContext context,String text){
      AlertDialog alert = AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
              SizedBox(width: 15,),
              Text(text),
            ],
          )
      );
      showDialog(
          barrierDismissible: false,
          context: context, builder: (BuildContext context)
      {
        return alert;
      }
      );
    }

    Future<void> phoneCredential(BuildContext context, String otp,String verId) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      try{
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verId,smsCode: otp);

        final User? user = (await _auth.signInWithCredential(credential)).user;

        if(user != null){
          addUser(context,user.uid);
        }
        else{
          print('login Failed');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Failed',
                    style: TextStyle(fontSize: 15,)),
              )
          );

        }
      }
      catch(e){
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('invalid otp',
                  style: TextStyle(fontSize: 15,)),
            )
        );
      }
    }

}