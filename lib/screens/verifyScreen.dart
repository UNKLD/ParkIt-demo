import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatelessWidget {
  static const id = 'verifyScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/logo.png',
                height: 200.0,
                width: 500.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 15.5,
              ),
              Text(
                'Verify',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 28.0,
                ),
              ),
              SizedBox(
                height: 1.5,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Verification Code',
                  labelStyle: TextStyle(fontSize: 18.0),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(130, 50),
                  primary: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Container(
                  height: 50.0,
                  width: 60.0,
                  child: Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                onPressed: () => print('verified'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
