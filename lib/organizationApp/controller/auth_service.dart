

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/organizationApp/view/dashboard.dart';
import 'package:med_rent/userApp/view/authentication/email_verification_screen.dart';

class AuthServices{

  CollectionReference organizations = FirebaseFirestore.instance.collection('organizations');


  void emailLogin(email, password,context) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      if(userCredential.user!.uid != null){
        Navigator.pushNamedAndRemoveUntil(context, Dashboard.id, (route) => false);
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('No user found for that email.')
            )
        );
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Wrong Password')
            )
        );
      }
    }catch(e){
      print(e);
    }
  }

  void emailRegister(email, password,context,organizationModel) async {

    DocumentSnapshot _result = await organizations.doc(email).get();


    if (_result.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
            'an account already exist with this email',
            style: TextStyle(fontSize: 15,),))
      );
    }
    else {

      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        if(userCredential.user!.uid != null)
        { //adding data to cloud firestore
          return organizations.doc(userCredential.user!.uid).set({
              'organizationName': organizationModel.organizationName,
              'email': userCredential.user!.email,
              'uid' : userCredential.user!.uid,
              'address': organizationModel.address,
              'contactNumber': organizationModel.contactNumber,
              'pincode': organizationModel.pincode,
              'city': organizationModel.city,
              'state': organizationModel.state,
          }).then((value) async{

            //email verification
            await userCredential.user!.sendEmailVerification().then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmailVerificationScreen(isorg: true),),);
            });


          }).catchError((onError){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to add user'),
                )
            );
          });
        }
      }on FirebaseAuthException catch(e){
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Weak Password')
              )
          );
        }else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('The account already exist for that email'),
              )
          );
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error occurred'),
            )
        );
        print(e);
      }
    }
  }
}