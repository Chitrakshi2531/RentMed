import 'package:flutter/material.dart';
import 'package:med_rent/main.dart';
import 'package:med_rent/organizationApp/view/login_screen.dart';
import 'package:med_rent/organizationApp/view/new_equipment_screen.dart';
import 'package:med_rent/organizationApp/view/register_screen.dart';
import 'package:med_rent/userApp/view/authentication/auth_screen.dart';
import 'package:med_rent/userApp/view/authentication/email_auth_screen.dart';
import 'package:med_rent/userApp/view/authentication/forgot_password.dart';
import 'package:med_rent/userApp/view/authentication/phone_auth_screen.dart';
import 'package:med_rent/userApp/view/home.dart';
import 'package:med_rent/userApp/view/home_Screen.dart';
import 'package:med_rent/on_boarding_screen.dart';
import 'package:med_rent/organizationApp/view/dashboard.dart';

import '../organizationApp/view/settings_screen.dart';
import '../userApp/view/settings_screen.dart';


final Map<String,WidgetBuilder> routes = {
  //common screens
  SplashScreen.id: (context) => const SplashScreen(),
  OnBoardingScreen.id: (context) => const OnBoardingScreen(),
  ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),

  //organization screens
  LoginPage.id: (context) => const LoginPage(),
  RegisterPage.id: (context) => const RegisterPage(),
  Dashboard.id: (context) => const Dashboard(),
  AddNewProduct.id :(context)=> const AddNewProduct(),
  Settings.id :(context) => const Settings(),

  // user screens
  AuthScreen.id: (context) => const AuthScreen(),
  EmailAuthScreen.id: (context) => const EmailAuthScreen(),
  PhoneAuthScreen.id: (context) => const PhoneAuthScreen(),
  HomeScreen.id: (context) => const HomeScreen(),
  Home.id: (context) => const Home(),
  UserSettings.id :(context) => const UserSettings(),

};