import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/Reserve.dart';
import 'package:untitled/screens/UpdateReserve.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool reserved = false;
  final databaseRef =
      FirebaseDatabase.instance.reference().child('reservations');

  @override
  void initState() {
    super.initState();
    hasReserved();
  }

  void hasReserved() {
    databaseRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) if (this.mounted)
        for (var value in snapshot.value.values) {
          if (value['user'] == 'currentUserId') {
            setState(() {
              reserved = true;
            });
          }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return reserved == true ? UpdateReserve() : Reserve();
  }
}
