import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/constants.dart';
import 'package:untitled/components/dynamicDialog.dart';
import 'package:untitled/screens/mainScreen.dart';

class FeedBack extends StatefulWidget {
  static const id = 'feedBackPage';

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  String subject;
  String message;
  final databaseRef = FirebaseDatabase.instance.reference().child('feedBack');

  void sendFeedBack() {
    databaseRef.push().set({'subject': subject, 'messege': message});
    dynamicDialog(context, 'Thanks!', 'Thank you for the feedback')
        .whenComplete(() => Navigator.popAndPushNamed(context, MainScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Feedback',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        toolbarHeight: 80.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180.0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Center(
                  heightFactor: 100.0,
                  child: Text(
                    'Send Feedback',
                    style: TextStyle(
                      fontSize: 20.5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: KinputDecoration.copyWith(
                      labelText: 'Enter subject',
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    onChanged: (value) {
                      subject = value;
                    },
                  ),
                  SizedBox(
                    height: 20.6,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Enter your messege here',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                    onChanged: (value) {
                      message = value;
                    },
                  ),
                  SizedBox(
                    height: 20.6,
                  ),
                  Container(
                    width: 180.0,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if ((subject != null && message != null) &&
                            (subject != '' && message != '')) {
                          sendFeedBack();
                        } else {
                          dynamicDialog(
                              context, 'Error', 'Please input data first');
                        }
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
