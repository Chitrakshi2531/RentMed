import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String id = 'register_page';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late String organizationName;
  late String email;
  late String password;
  late String address;
  late int contactNumber;
  late String confirmPassword;
  late int pincode;
  late String city;
  late String state;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  @override
  void initState(){
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: Container(
              height: size.height * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    organizationName = value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Organization Name',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                  ),
                                )
                            ),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  final bool isvalid = EmailValidator.validate(value);
                                  if(value.isNotEmpty && isvalid == false)
                                  {
                                    return 'Enter valid Email';
                                  }
                                  setState((){
                                    email = value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color:  Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                  ),
                                )
                            ),
                            TextFormField(
                                keyboardType: TextInputType.phone,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    contactNumber = int.parse(value);
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Contact Number',
                                  labelStyle: TextStyle(
                                    color:  Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                  ),
                                )
                            ),
                            TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    password = value;
                                  });
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                obscureText: !_passwordVisible,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      color:  Theme.of(context).primaryColor,
                                      fontSize: 15,
                                    ),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                    ),

                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible?Icons.visibility:Icons.visibility_off,
                                          color:  Theme.of(context).primaryColor,
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        }
                                    )

                                )
                            ),
                            TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    confirmPassword = value;
                                  });
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                obscureText: !_confirmPasswordVisible,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(
                                      color:  Theme.of(context).primaryColor,
                                      fontSize: 15,
                                    ),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                    ),

                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _confirmPasswordVisible?Icons.visibility:Icons.visibility_off,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            _confirmPasswordVisible = !_passwordVisible;
                                          });
                                        }
                                    )

                                )
                            ),
                            TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    pincode = int.parse(value);
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Pincode',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                  ),
                                )
                            ),
                            TextFormField(
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    address = value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                  ),
                                )
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    city = value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                  ),
                                )
                            ),
                            TextFormField(
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'This field is required';
                                  }
                                  setState((){
                                    state = value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'State',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6))
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                  ),
                                )
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 220,
                              child: ElevatedButton(
                                  onPressed: (){
                                    if(_formKey.currentState!.validate())
                                    {
                                      Navigator.pushNamed(context, Dashboard.id);
                                    }

                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                                child: Text(
                                    'By creating an account, you accept RentMed\'s Terms of Service and Privacy Policy',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )
                )
            ),
          )
        ],
      )
    );
  }
}
