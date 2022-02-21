
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password_screen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Forgot Password'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock,color: Theme.of(context).primaryColor,size: 100,),
                  SizedBox(height: 10,),
                  Text(
                    'Forgot\nPassword?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    'Send us your email,\nwe will send link to resent your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05,),
                  Form(
                    key: _formKey,
                    child: TextFormField(
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
                        return null;
                      },
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        labelText: 'Registered Email',
                        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1,),
                  Center(
                    child: SizedBox(
                      width: 270,
                      child: ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(10.0),
                          ),
                          child: Center(
                              child: Text(
                                  'Send',
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
                ],
              ),
            )
        ),
    );
  }
}
