import 'package:flutter/material.dart';
import 'package:untitled/components/roundedButton.dart';
import 'package:untitled/screens/loginScreen.dart';
import 'registerScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 160.0,
                    child: Image.asset(
                      'images/logo.png',
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'ParkIT',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            RoundedButton(
              'Login',
              () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            RoundedButton(
              'Register',
              () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
