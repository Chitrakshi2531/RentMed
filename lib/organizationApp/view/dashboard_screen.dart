import 'dart:async';

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int rseconds = 0;
  int eseconds = 0;
  int rmax = 60;
  int emax = 30;
  Timer? timer;

  void startAnimation() {
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if(rseconds < rmax)
          rseconds++;
        if(eseconds < emax)
          eseconds++;
        if(rseconds >= rmax && eseconds >= emax)
          {
            timer.cancel();
          }
      });
    });
  }

  @override
  void initState() {
    rseconds = 0;
    eseconds = 0;
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 38,
                )
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            SizedBox(
              height: size.height * 0.20,
              width: size.width * 0.7,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '$eseconds',
                          style: TextStyle(
                            fontSize: 40,
                          )
                        ),
                      ),
                      Text(
                          'Equipments',
                          style: TextStyle(
                            fontSize: 20,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: size.height * 0.2,
              width: size.width * 0.7,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 4,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                            '$rseconds',
                            style: TextStyle(
                              fontSize: 40,
                            )
                        ),
                      ),
                      Text(
                          'Rented',
                          style: TextStyle(
                            fontSize: 20,
                          ))
                    ],
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}
