import 'package:flutter/material.dart';
import 'package:med_rent/OrganizationApp/view/dashboard_Screen.dart';
import 'package:med_rent/OrganizationApp/view/equipment_Screen.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:med_rent/organizationApp/view/settings_screen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  static const String id = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Widget? _child;

  @override
  void initState()
  {
    _child = DashboardScreen();
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
            icon: Icons.list_alt,
          ),
          FluidNavBarIcon(
            icon: Icons.settings_outlined,
          ),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
          barBackgroundColor: Theme.of(context).primaryColor,
          iconSelectedForegroundColor: Colors.white,
          iconUnselectedForegroundColor: Colors.white,
        ),

      ),
    );
  }
  void _handleNavigationChange(int index){
    setState(() {
      switch(index){
        case 0:
          _child = DashboardScreen();
          break;
        case 1:
          _child = EquipmentScreen();
          break;
        case 2:
          _child = Settings();
          break;
      }
    });
  }
}
