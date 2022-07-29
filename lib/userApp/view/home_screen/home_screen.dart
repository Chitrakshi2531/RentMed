import 'package:flutter/material.dart';

import 'components/category_list.dart';
import 'components/header.dart';
import 'components/recommended_list.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(50),),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Header()
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        'Categories',
                         textAlign: TextAlign.left,
                         style: TextStyle(
                           fontSize: 22,
                           color: Theme.of(context).primaryColor,
                           fontWeight: FontWeight.bold,
                         )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                        height: size.height *0.1,
                        width: size.width,
                        child: CategoryList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        'Recommended',
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    width: size.width,
                    child: RecommendedList(),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ]
          ),
        ),
      )
    );
  }
}
