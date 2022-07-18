import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:med_rent/on_boarding_screen.dart';
import 'package:med_rent/organizationApp/controller/equipment_provider.dart';
import 'package:med_rent/organizationApp/view/dashboard.dart';
import 'package:med_rent/userApp/view/home.dart';
import 'package:med_rent/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ChangeNotifierProvider(
        create: (context) => EquipmentProvider(),
        child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:  Colors.cyan.shade900,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.cyan.shade900,
          selectionColor: Colors.cyan.shade900,
          selectionHandleColor: Colors.cyan.shade900,
        )
      ),
      initialRoute: SplashScreen.id,
      routes: routes,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _initialized = false;
  bool _error = false;
  void initializedFlutterFire() async{
    try{
      await Firebase.initializeApp();
      setState((){
        _initialized = true;
      });
    }
    catch(e){
      setState((){
        _error = true;
      });
    }
  }
  @override
  void initState() {
    initializedFlutterFire();
    Timer(const Duration(seconds: 3),
        () {
          FirebaseAuth.instance.authStateChanges().listen((User? user) async{
            if(user == null)
              Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
            else{
              CollectionReference users = FirebaseFirestore.instance.collection('organizations');
              DocumentSnapshot _result = await users.doc(user.uid).get();
              if(_result.exists)
                Navigator.pushReplacementNamed(context, Dashboard.id);
              else
                Navigator.pushReplacementNamed(context, Home.id);
            }
            });
          // Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_error){
      return MaterialApp(
        home:Scaffold(
          body: Center(child: Text(
            'Something Went Wrong',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
            )
          ),)
        ),
        builder: EasyLoading.init(),
      );
    }
    if(!_initialized){
      return MaterialApp(
          home:Scaffold(
              body: Center(child: Text(
                  'Loading',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                  )
              ),)
          )
      );
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(child: Image.asset('assets/image/logo.png')));
  }
}
