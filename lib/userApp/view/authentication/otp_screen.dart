import 'package:flutter/material.dart';
import 'package:med_rent/userApp/controller/phoneauth_services.dart';
import 'package:med_rent/userApp/view/authentication/phone_auth_screen.dart';



class OTPScreen extends StatefulWidget {
  static const String id = 'otp_screen';
  final String number,verId;

  OTPScreen({required this.number,required this.verId});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();
  bool _loading = false;
  String error = "";
  PhoneAuthServices _services = PhoneAuthServices();



  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',
        style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false, //to remove back screen
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(height: 50,),
            Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'We send a 6-digit code to',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10,),
            Container(
              width: size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( widget.number,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),),
                  InkWell(
                    onTap: (){
                      Navigator.popUntil(context, ModalRoute.withName(PhoneAuthScreen.id));
                    },
                    child: Icon(Icons.edit),
                  )
                ]
              )
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    controller: _text1,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                    ),
                    onChanged: (value){
                      if(value.length == 1 ){
                        node.nextFocus();
                      }
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    controller: _text2,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                    ),
                    onChanged: (value){
                      if(value.length == 1){
                        node.nextFocus();
                      }
                      if(value.length == 0){
                        node.previousFocus();
                      }
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    controller: _text3,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                    ),
                    onChanged: (value){
                      if(value.length == 1){
                        node.nextFocus();
                      }
                      if(value.length == 0){
                        node.previousFocus();
                      }
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    controller: _text4,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                    ),
                    onChanged: (value){
                      if(value.length == 1){
                        node.nextFocus();
                      }
                      if(value.length == 0){
                        node.previousFocus();
                      }
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    controller: _text5,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                    ),
                    onChanged: (value){
                      if(value.length == 1){
                        node.nextFocus();
                      }
                      if(value.length == 0){
                        node.previousFocus();
                      }
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    controller: _text6,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                    ),
                    onChanged: (value){
                      if(value.length == 1){
                        if(_text1.text.length == 1){
                          if(_text2.text.length == 1){
                            if(_text3.text.length == 1){
                              if(_text4.text.length == 1){
                                if(_text5.text.length == 1){
                                  if(_text6.text.length == 1){
                                    //the otp we recived
                                    String _otp = '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';
                                    //login
                                    setState(() {
                                      _loading = true;
                                    });
                                    _services.phoneCredential(context,_otp,widget.verId);
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                      else{
                        setState((){
                          _loading = false;
                        });
                      }
                      if(value.length == 0){
                        node.previousFocus();
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            if(_loading)
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(error,style: TextStyle(color: Colors.red,fontSize: 12)),
          ]
        ),
      ),
    );
  }
}
