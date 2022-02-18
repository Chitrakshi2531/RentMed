import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:med_rent/userApp/screens/authentication/email_auth_screen.dart';
import 'package:med_rent/userApp/screens/authentication/google_auth.dart';
import 'package:med_rent/userApp/screens/authentication/phone_auth_screen.dart';
import 'package:med_rent/userApp/services/phoneauth_services.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String id = 'auth_screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Column(
              children: [
                Container(
                  color: Colors.white,
                  height: size.height * 0.45,
                  width: size.width,
                  child: Center(
                    child: Image.asset('assets/image/transparent_logo.png'),
                  ),
                ),
                Container(
                    height: size.height * 0.55,
                    child: Center(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, PhoneAuthScreen.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                  child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: Icon(Icons.phone_android_outlined, color: Colors.black),
                                        ),
                                        SizedBox( width: 8,),
                                        Text('Continue with Phone',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )
                                        )
                                      ]
                                  )),
                            ),
                            SizedBox(height: 5,),
                            SizedBox(
                              width: size.width * 0.7,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, EmailAuthScreen.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                  child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: Icon(Icons.email, color: Colors.black),
                                        ),
                                        SizedBox( width: 8,),
                                        Text('Continue with Email',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )
                                        )
                                      ]
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('OR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                            ),
                            SizedBox(
                              width: size.width * 0.7,
                              height: 44,
                              child: SignInButton(
                                  Buttons.Google,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  text: ('Continue with Google'),
                                  onPressed: () async{
                                    User? user = await GoogleAuthentication.signInWithGoogle(context: context);
                                    if(user != null)
                                      {
                                        PhoneAuthServices _authentication = PhoneAuthServices();
                                        _authentication.addUser(context, user.uid);
                                      }

                                  }),
                            ),
                          ]
                      ),
                    )
                ),

              ]
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    'if you continue, you are accepting \n Terms and Conditions and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )
                )
            ),
          )
        ],
      ),
    );
  }
}
