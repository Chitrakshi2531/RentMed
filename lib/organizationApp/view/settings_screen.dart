import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static const String id = 'settings_screen';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _name = "";
  void getData() async{
    User? user = FirebaseAuth.instance.currentUser ;
    CollectionReference _org = FirebaseFirestore.instance.collection('organizations');
    DocumentSnapshot _result = await _org.doc(user?.uid).get();
    _name = _result['organizationName'];
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
              _name,
              style: TextStyle(
                fontSize: 30,
              ),
          ),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          icon: const Icon(Icons.logout_rounded,color: Colors.white),
          label: const Text('Logout', style: TextStyle(color: Colors.white),),
          onPressed: ()async{
            await FirebaseAuth.instance.signOut();
          },
        )
      ]
    );
  }
}
