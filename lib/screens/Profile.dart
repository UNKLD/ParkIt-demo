import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const id = "ProfilePage";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        toolbarHeight: 80.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 280.0,
                width: double.infinity,
                padding: EdgeInsets.only(top: 50.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("images/user.png"),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito",
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                      width: 210.0,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    color: Colors.blueAccent,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(Icons.phone, color: Colors.white),
                      title: Text(
                        'User Phone',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    color: Colors.blueAccent,
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      title: Text(
                        'User Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
