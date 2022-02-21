import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/authentication/email_auth_screen.dart';
import 'package:med_rent/userApp/controller/phoneauth_services.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);
  static const String id = 'phone_auth_screen';

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  var countryController = TextEditingController(text: '+91');
  var phoneNumberController = TextEditingController();
  bool validate = false;

  String counterText = '0';
  PhoneAuthServices _service = PhoneAuthServices();




  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white,),
        title: Text('Login', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Text(
                'Enter your Phone',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'We will send confirmation code to your phone',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: TextFormField(
                        controller: countryController,
                        enabled: false,
                        decoration: InputDecoration(
                          counterText: '10',
                          labelText: 'Country',
                          labelStyle: TextStyle(color:Theme.of(context).primaryColor, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex:3,
                      child: TextFormField(
                        onChanged: (value){
                          if(value.length == 10)
                            {
                              setState(() {
                                validate = true;
                              });
                            }
                          else{
                            validate = false;
                          }
                        },
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        maxLength: 10,
                        autofocus: true,
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Number',
                          labelStyle: TextStyle(color:Theme.of(context).primaryColor, fontSize: 18),
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.2,),
              Center(
                child: SizedBox(
                  width: 270,
                  child: AbsorbPointer(
                    absorbing: validate == true ? false : true,
                    child: ElevatedButton(
                        onPressed: (){
                          String number = '${countryController.text}${phoneNumberController.text}';
                          print(number);
                         _service.showAlertDialog(context,'Sending OTP');
                         _service.verifyPhoneNumber(context, number);
                         // Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: validate == true ? Theme.of(context).primaryColor : Colors.grey,
                          padding: EdgeInsets.all(10.0),
                        ),
                        child: Center(
                            child: Text(
                                'Send OTP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )
                            )
                        )

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex:1,
                      child: SizedBox(
                        height: 2,
                        child: Container( color: Theme.of(context).primaryColor,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('OR'),
                    ),
                    Expanded(
                      flex:1,
                      child: SizedBox(
                        height: 2,
                        child: Container( color: Theme.of(context).primaryColor,),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 270,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, EmailAuthScreen.id);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(10.0),
                      ),
                      child: Center(
                          child: Text(
                              'Continue with Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )
                          )
                      )

                  ),
                ),
              ),


            ]
          ),
        ),
      ),
    );
  }
}
