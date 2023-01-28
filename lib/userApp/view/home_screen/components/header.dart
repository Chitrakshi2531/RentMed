import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/home_screen/search_screen.dart';
class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.1, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children:[
                        TextSpan(
                            text:  'Hello, What Are You \nLooking For?  ',
                            style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                              )
                        ),
                        TextSpan(
                          text: '👀',
                            style: TextStyle(
                            fontSize: 28,
                          )
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              Icon(Icons.notifications_none,
              color: Colors.white),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 40, 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search()),);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.search,size: 20,color: Theme.of(context).primaryColor,),
                  ),
                  Text(
                    'Search Equipment',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
