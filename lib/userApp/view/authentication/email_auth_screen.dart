import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/authentication/forgot_password.dart';
import 'package:med_rent/userApp/controller/email_auth_services.dart';
import 'forgot_password.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);
  static const String id = 'email_auth_screen';

  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool _login = true;
  bool _validate = false;
  bool _passwordVisible = false;
  bool _loading = false;
  EmailAuthentication _services = EmailAuthentication();

  void _validateEmail() {
    if(_formKey.currentState!.validate()){
      setState(() {
        _validate = false;
        _loading = true;
      });
      _services.gerAdminCredential(email, password, context, _login).then((value){
        setState(() {
          _loading = false;
        });
      });
    }

  }

  @override
  void initState(){
    super.initState();
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 40,right: 40),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              Text(
                'Welcome',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${_login ? 'Sign in to your Account' : 'Enter Email and Password to Register'}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Center(
                child: Container(
                  // height : size.height * 0.25,
                  // width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            children: [
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Colors.white),
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
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  color: Colors.white.withOpacity(0.6),
                                  height: 2,
                                ),
                              ),
                              TextFormField(
                                  validator: (value){
                                    if(value == null || value.isEmpty)
                                    {
                                      return 'This field is required';
                                    }
                                    if(value.isNotEmpty){
                                      if(value.length < 8)
                                      {
                                        return 'Password must be at least 8 characters';
                                      }
                                    }
                                    setState((){
                                      password = value;
                                    });
                                    return null;
                                  },
                                  onChanged: (value){
                                    if(value.isNotEmpty){
                                      if(value.length >= 8)
                                        {
                                          setState(() {
                                            _validate = true;
                                          });
                                        }
                                      else
                                        setState(() {
                                          _validate = false;
                                        });
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: !_passwordVisible,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      icon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible?Icons.visibility:Icons.visibility_off,
                                            color:  Colors.white,
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          }
                                      )

                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    )
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context,ForgotPasswordScreen.id);
                  },
                  child: Text(
                    'forgot password ?',
                    style: TextStyle(
                      color: Colors.white,
                    ),)
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Center(
                child: SizedBox(
                  width: 270,
                  child: ElevatedButton(
                      onPressed: (){
                        _validateEmail();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: _validate ? Colors.white : Colors.white.withOpacity(0.3),
                        padding: EdgeInsets.all(10.0),
                      ),
                      child: Center(
                          child: _loading? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                          ) : Text(
                              '${_login ? 'SignIn' : 'Register'}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                              )
                          )
                      )

                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_login ? 'Don\'t': 'Already'} have an Account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _login = !_login;
                          });
                        },
                        child: Text(
                          '${_login?'SignUp':'SignIn'}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                      'By creating an account, you accept RentMed\'s Terms of Service and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )
                  )
              )
            ]
        ),
      ),
    );
  }

}
