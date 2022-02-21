import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  static const String id = 'dashboard_screen';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('dashboard'),
      ),
    );
  }
}
