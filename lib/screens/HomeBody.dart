import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String fullName = '';
  String email = '';
  String tariff = '';
  String tSlots = '';
  String aSlots = '';
  var subscription;

  final databaseRef = FirebaseDatabase.instance.reference().child('users');

  void getUserData() {
    databaseRef.once().then(
      (DataSnapshot snapshot) {
        if (snapshot.value != null) if (this.mounted)
          for (var value in snapshot.value.values) {
            if (value['email'] == 'email@email.com')
              setState(() {
                fullName = value['FullName'];
                email = value['email'];
              });
          }
      },
    );
  }

  void getTarrif() {
    DatabaseReference newRef = FirebaseDatabase.instance.reference();
    newRef.child('tariff').once().then((value) {
      if (value != null && this.mounted)
        setState(() {
          tariff = value.value['amount'];
        });
    });
  }

  void currentLotInfo() {
    DatabaseReference newRef =
        FirebaseDatabase.instance.reference().child('parkingLot');
    newRef.once().then((DataSnapshot snap) {
      if (snap.value != null && this.mounted)
        for (var value in snap.value.values) {
          setState(() {
            aSlots = value['availableSlots'].toString();
          });
        }
    });
  }

  void getLotInfo() {
    subscription = FirebaseDatabase.instance
        .reference()
        .child('parkingLot')
        .onChildChanged
        .listen((event) {
      currentLotInfo();
      getTarrif();
    });
  }

  @override
  void initState() {
    super.initState();
    getLotInfo();
    currentLotInfo();
    getTarrif();
  }

  @override
  void dispose() {
    if (this.mounted) subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                child: Text(
                  'ParkIt',
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
          Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            fullName == '' ? 'Loading..' : "Welcome $fullName",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.all(18.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Parking Lot info',
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Tariff = $tariff',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Available slots = $aSlots',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
