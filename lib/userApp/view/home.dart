import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/home_Screen.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:med_rent/userApp/view/settings_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget? _child;

  @override
  void initState()
  {
    _child = HomeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
            icon: Icons.dashboard_outlined,
          ),
          FluidNavBarIcon(
            icon: Icons.dashboard_outlined,
          ),
          FluidNavBarIcon(
            icon: Icons.dashboard_outlined,
          ),
          FluidNavBarIcon(
            icon: Icons.dashboard_outlined,
          ),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
          barBackgroundColor: Theme.of(context).primaryColor,
          iconSelectedForegroundColor: Theme.of(context).primaryColor,
          iconUnselectedForegroundColor: Colors.white,
        ),

      ),
    );
  }
  void _handleNavigationChange(int index){
    setState(() {
      switch(index){
        case 0:
          _child = HomeScreen();
          break;
        case 1:
          _child = HomeScreen();
          break;
        case 2:
          _child = UserSettings();
          break;

      }
    });
  }
}
