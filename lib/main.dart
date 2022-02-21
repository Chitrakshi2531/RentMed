import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:med_rent/on_boarding_screen.dart';
import 'package:med_rent/organizationApp/view/dashboard_screen.dart';
import 'package:med_rent/userApp/view/authentication/auth_screen.dart';
import 'package:med_rent/userApp/view/authentication/email_auth_screen.dart';
import 'package:med_rent/userApp/view/authentication/email_verification_screen.dart';
import 'package:med_rent/userApp/view/authentication/forgot_password.dart';
import 'package:med_rent/userApp/view/authentication/phone_auth_screen.dart';
import 'package:med_rent/userApp/view/home_Screen.dart';

import 'organizationApp/view/login_screen.dart';
import 'organizationApp/view/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
      routes: {
        //common screens
        SplashScreen.id: (context) => const SplashScreen(),
        OnBoardingScreen.id: (context) => const OnBoardingScreen(),
        EmailVerificationScreen.id: (context) => const EmailVerificationScreen(),
        ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),

        //organization screens
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        Dashboard.id: (context) => const Dashboard(),

        // user screens
        AuthScreen.id: (context) => const AuthScreen(),
        EmailAuthScreen.id: (context) => const EmailAuthScreen(),
        PhoneAuthScreen.id: (context) => const PhoneAuthScreen(),
        HomeScreen.id: (context) => const HomeScreen(),


      },
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
          // FirebaseAuth.instance.authStateChanges().listen((User? user) {
          //   if(user == null)
          //     Navigator.pushReplacementNamed(context, PhoneAuthScreen.id);
          //   else
          //   Navigator.pushReplacementNamed(context, OnBoardingScreen.id);});
          Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
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
        )
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
