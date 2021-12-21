import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/mainScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class NearBy extends StatefulWidget {
  static const id = 'NearbyScreen';
  @override
  _NearByState createState() => _NearByState();
}

class _NearByState extends State<NearBy> {
  final databaseRef = FirebaseDatabase.instance.reference().child('nearByLots');

  final List<Widget> children = [];
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else
      print('cant launch $url');
  }

  @override
  Widget build(BuildContext context) {
    // getNearBy();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.popAndPushNamed(context, MainScreen.id);
          },
        ),
        title: Text(
          'Near by Parking lots',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        toolbarHeight: 80.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0,
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
                  'Near by Parking Lots',
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
          StreamBuilder(
            stream: databaseRef.onValue,
            builder: (context, snap) {
              if (snap.hasData && snap.data.snapshot != '') {
                Map data = snap.data.snapshot.value;
                List item = [];
                data.forEach(
                    (index, data) => item.add({"key": index, ...data}));
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(15.0),
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      final name = item[index]['name'];
                      final tariff = item[index]['tariff'];
                      final contact = item[index]['aditionalInfo'];
                      final slots = item[index]['totalSlots'];
                      final phone = item[index]['phone'];
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.shade400,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                getNearBy(name, tariff, contact, slots, phone);
                              },
                              leading: Icon(
                                Icons.local_parking_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                item[index]['name'],
                                style: TextStyle(
                                  fontSize: 20.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else
                return Center(
                    child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ));
            },
          ),
        ],
      ),
    );
  }

  void getNearBy(name, tariff, contact, slots, phone) {
    //get contact from firebase

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                CustomListTile(
                  leading: 'Name:',
                  title: name,
                ),
                CustomListTile(
                  leading: 'Tariff:',
                  title: tariff,
                ),
                CustomListTile(
                  leading: 'Contact:',
                  title: contact,
                ),
                CustomListTile(
                  leading: "Total No of Slots:",
                  title: slots,
                ),
                CustomListTile(
                  leading: 'Phone: ',
                  title: phone,
                ),
                ElevatedButton(
                  onPressed: () {
                    _makePhoneCall("tel:$phone");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Make call',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //end of class
}

class CustomListTile extends StatelessWidget {
  final String leading;
  final String title;

  const CustomListTile({Key key, this.leading, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: TextStyle(
          fontSize: 15.2,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
