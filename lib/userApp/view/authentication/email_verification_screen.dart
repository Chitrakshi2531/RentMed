
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/organizationApp/view/dashboard.dart';
import 'package:med_rent/userApp/view/home.dart';
import 'package:open_mail_app/open_mail_app.dart';


class EmailVerificationScreen extends StatefulWidget {
  static const String id = 'email_verification_screen';
  final bool isorg;
  const EmailVerificationScreen({required this.isorg});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isverified = false;
  Timer? timer;
  @override
  void initState()
  {
    super.initState();
    timer = Timer.periodic(
      Duration(seconds: 3),
        (_) => checkEmailVerified(),
    );
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    if(FirebaseAuth.instance.currentUser!.emailVerified) {
      setState(() {
        _isverified = true;
      });
    }
    if(_isverified) {
      timer?.cancel();
      if(widget.isorg)
        {
          Navigator.pushNamedAndRemoveUntil(context, Dashboard.id, (route) => false);
        }
      else{
        Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
      }
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Theme.of(context).primaryColor
                ),
              ),
              SizedBox(height: 15,),
              Text('Check your email to verify your registered Email'),
              SizedBox(height: size.height * 0.1,),
              Center(
                child: SizedBox(
                  width: 270,
                  child: ElevatedButton(
                      onPressed: () async{
                        var result = await OpenMailApp.openMailApp();

                        if(!result.didOpen && !result.canOpen){
                          showNoMailAppsDialog(context);
                        }
                        else if(!result.didOpen && result.canOpen)
                        {
                          showDialog(
                            context: context,
                            builder: (_){
                              return MailAppPickerDialog(
                                mailApps: result.options,
                              );
                            },
                          );
                        }
                        },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(10.0),
                      ),
                      child: Center(
                          child: Text(
                              'Open Mail App',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )
                          )
                      )

                  ),
                ),
              ),

            ]
          ),
        ),
      )
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Open Mail App'),
          content: Text('No mail apps installed'),
          actions: [
            TextButton(
                onPressed: (){
                    Navigator.pop(context);
                  },
                child: Text('OK')
            )
          ],
        );
      },
    );
  }


}
