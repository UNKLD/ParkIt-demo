import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class About extends StatefulWidget {
  static const id = 'aboutPage';

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String about = '';
  final databaseRef = FirebaseDatabase.instance.reference().child('parkingLot');

  @override
  Widget build(BuildContext context) {
    getAbout();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'About',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        toolbarHeight: 80.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  'About',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  about == '' ? 'Loading...' : about,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getAbout() {
    //get contact from firebase
    databaseRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) if (this.mounted)
        for (var value in snapshot.value.values) {
          setState(() {
            about = value['about'];
          });
        }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
