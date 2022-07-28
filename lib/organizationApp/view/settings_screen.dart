import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../on_boarding_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static const String id = 'settings_screen';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/image/profile_picture.png'),
                    radius: 50,
                  )),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: size.width * 0.7,
                child: Center(
                  child: ElevatedButton(
                      onPressed: ()async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context,OnBoardingScreen.id,(route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(10.0),
                      ),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Icon(Icons.logout_rounded,color: Colors.white),
                              ),
                              SizedBox( width: 8,),
                              Text(
                                'Logout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ]
                        ),
                      )),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
