import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/About.dart';
import 'package:untitled/screens/Check.dart';
import 'package:untitled/screens/FeedBack.dart';
import 'package:untitled/screens/NearBy.dart';
import 'package:untitled/screens/Profile.dart';
import 'package:untitled/screens/parkCarScreen.dart';
import 'package:untitled/screens/HomeBody.dart';
import 'package:untitled/screens/unParkCarScreen.dart';

class MainScreen extends StatefulWidget {
  static const id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeBody(),
    ParkCarScreen(),
    UnParkCarScreen(),
    Check(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blueAccent,
        title: Text(
          'ParkIT',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        toolbarHeight: 80.0,
      ),
      endDrawer: Drawer(
        elevation: 15.0,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   height: 150.0,
              //   width: 150.0,
              //   child: Image.asset(
              //     "images/logo.png",
              //     scale: 5.0,
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.only(bottom: 40.0),
              //   child: Text(
              //     'ParkIt',
              //     style: TextStyle(
              //       fontSize: 40.0,
              //       color: Colors.black,
              //       fontWeight: FontWeight.w700,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),
              DrawerHeader(
                  padding: EdgeInsets.only(bottom: 10.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          size: 85,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Current User",
                          style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.8,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Divider(
                          color: Colors.black,
                          height: 5.5,
                          indent: 10.0,
                          endIndent: 10.0,
                        ),
                      ],
                    ),
                  )),
              EndDrawerItem(
                leading: Icons.person,
                title: 'Visit Profile',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Profile.id);
                },
              ),
              SizedBox(
                height: 18.0,
              ),
              EndDrawerItem(
                leading: Icons.local_parking,
                title: 'Near by Parking lots',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, NearBy.id);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              EndDrawerItem(
                leading: Icons.feedback,
                title: 'Feedback',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, FeedBack.id);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              EndDrawerItem(
                leading: Icons.info,
                title: 'About',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, About.id);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 19.0,
          elevation: 100.0,
          selectedIconTheme: IconThemeData(
            size: 35.0,
            color: Colors.blueAccent,
          ),
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.home_filled),
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_car_wash),
              label: 'Park Car',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.time_to_leave),
              icon: Icon(Icons.local_car_wash_sharp),
              label: 'UnPark Car',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.access_time_outlined,
              ),
              icon: Icon(
                Icons.access_time,
              ),
              label: 'Reserve',
            ),
          ]),
      body: _children[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

//UI classes
class EndDrawerItem extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData leading;

  const EndDrawerItem({this.onPressed, this.title, this.leading}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 60.0,
      child: ListTile(
        onTap: onPressed,
        leading: Icon(
          leading,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 13.1, color: Colors.white),
        ),
      ),
    );
  }
}
