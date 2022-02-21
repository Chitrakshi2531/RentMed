import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:med_rent/organizationApp/view/login_screen.dart';
import 'package:med_rent/userApp/view/authentication/auth_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const String id = 'onboard-screen';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int  _currentPage = 0 ;
  late Timer _timer;
  double _scrollerPosition = 0 ;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      }
      else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }
  @override
  void dispose()
  {
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
    );
    return Scaffold(

      body: Stack(
            children:[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: size.height * 0.18,
                    color: Theme.of(context).primaryColor,
                    child: Align(
                    alignment: Alignment.bottomCenter,
                      child:Row(
                          children: [
                            Container(
                                width: size.width,
                                height: size.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(70),
                                      // topRight: Radius.circular(70),
                                    )
                                )
                            ),
                          ]
                      )

                )
                ),
              ),
              PageView(
                controller: _pageController,
                onPageChanged: (val){
                  setState(() {
                    _scrollerPosition = val.toDouble();
                    _currentPage = val.toInt();
                  });
                },
                children: [
                  OnBoardPage(
                      boardColumn: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          Text(
                              'Medical Equipment \n On Rent',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30,
                              )
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SvgPicture.asset(
                            'assets/illustrations/man_on_wheelchair.svg',
                            width: size.width * 0.3,
                            height: size.height * 0.4,
                          ),
                        ],
                      )
                  ),
                  OnBoardPage(
                      boardColumn: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          Text(
                              'Medical Equipment \n On Rent',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30
                              )),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SvgPicture.asset(
                            'assets/illustrations/man_on_bed.svg',
                            width: size.width * 0.3,
                            height: size.height * 0.4,
                          ),
                        ],
                      )
                  ),
                  OnBoardPage(
                      boardColumn: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          Text(
                              'Check Availability \n Of Equipment',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30
                              )),
                          SvgPicture.asset(
                            'assets/illustrations/availability.svg',
                            width: size.width * 0.35,
                            height: size.height * 0.45,
                          ),
                        ],
                      )
                  ),
                  OnBoardPage(
                      boardColumn: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          Text(
                              'Place Request \n For Renting \n Equipment',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30
                              )),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Image.asset(
                            'assets/illustrations/request.png',
                          ),
                        ],
                      )
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DotsIndicator(
                      dotsCount: 4,
                      position: _scrollerPosition,
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Container(
                              width: size.width * 0.95,
                              height: size.height * 0.22,
                              child: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.65,
                                        child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.pushNamed(context, AuthScreen.id);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              padding: EdgeInsets.all(10.0),
                                            ),

                                            child: Text(
                                                "Start Exploring",
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                )
                                            )
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.65,
                                        child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.pushNamed(context, LoginPage.id);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                              // shape: RoundedRectangleBorder(
                                              //   borderRadius: BorderRadius.circular(30),
                                              // )
                                            ),
                                            child: Text(
                                                "Continue as Organization",
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                )
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                          height: 30
                                      )
                                    ]
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(70),
                                    // topRight: Radius.circular(70),
                                  )
                              )
                          ),
                        ]
                      )
                    ],
                  )
              ),
            ]
      )
    );
  }
}

class OnBoardPage extends StatelessWidget {

  final Column? boardColumn;
  const OnBoardPage({Key? key , this.boardColumn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
         child: boardColumn,

      );
  }
}
