import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/constants.dart';
import 'package:untitled/components/roundedButton.dart';
import 'package:untitled/screens/verifyScreen.dart';

class RegisterScreen extends StatefulWidget {
  static const id = 'registerScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String fullName = '';
  String email = '';
  String password = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
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
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Text Fields
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        decoration:
                            KinputDecoration.copyWith(labelText: 'Full Name'),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(
                        height: 10.6,
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: KinputDecoration.copyWith(
                            labelText: 'Phone Number'),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.6,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            KinputDecoration.copyWith(labelText: 'Email'),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.6,
                      ),
                      TextField(
                        obscureText: true,
                        decoration:
                            KinputDecoration.copyWith(labelText: 'Password'),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.8,
                      ),
                    ],
                  ),
                ),
                RoundedButton('Register', () {
                  Navigator.pushNamed(context, VerifyScreen.id);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final databaseRef = FirebaseDatabase.instance.reference().child('users');
  void registerUser() async {
    User user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;
    if (user != null) {}
  }
}
