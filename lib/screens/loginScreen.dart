import 'package:flutter/material.dart';
import 'package:untitled/components/progressDialog.dart';
import 'package:untitled/components/roundedButton.dart';
import 'package:untitled/components/constants.dart';
import 'package:untitled/screens/mainScreen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset(
                      'images/logo.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.5,
                ),
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),

                //Text Fields
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            KinputDecoration.copyWith(labelText: 'Email'),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(
                        height: 20.6,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            KinputDecoration.copyWith(labelText: 'Password'),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 9.8,
                      ),
                    ],
                  ),
                ),
                RoundedButton('Login', () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ProgressDialog(
                      message: 'Logging In...',
                    ),
                  );
                  try {
                    if (email.isEmpty) {
                      print('please input all required information');
                    }
                    print(email);
                    print(password);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, MainScreen.id);
                  } catch (e) {
                    print(e);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
