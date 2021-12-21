import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticketview/ticketview.dart';
import 'package:untitled/components/dynamicDialog.dart';
import 'package:untitled/screens/NearBy.dart';
import 'package:untitled/screens/mainScreen.dart';

class ParkCarScreen extends StatefulWidget {
  static const id = "parkCarScreen";
  @override
  _ParkCarScreenState createState() => _ParkCarScreenState();
}

class _ParkCarScreenState extends State<ParkCarScreen> {
  var subscription;
  String tariff = '';
  int initCount = 0;
  final databaseRef = FirebaseDatabase.instance.reference().child('parkingLot');

  void checkSlots() {
    databaseRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null)
        for (var value in snapshot.value.values) {
          if (value['availableSlots'] == 0) {
            dynamicDialog(context, 'Sorry', 'There are no avaiable slots')
                .whenComplete(() => Navigator.pushNamed(context, NearBy.id));
          } else
            return;
        }
    });
  }

  void getTarrif() {
    DatabaseReference newRef = FirebaseDatabase.instance.reference();
    newRef.child('tariff').once().then((value) {
      if (value.value != null && this.mounted)
        setState(() {
          tariff = value.value['amount'];
        });
    });
  }

  void getParked() {
    subscription = FirebaseDatabase.instance
        .reference()
        .child('parkedUsers')
        .onChildAdded
        .listen((data) {
      if (initCount != 0) {
        if (data.snapshot.value['user'] == 'GasfCqudf8WTuDzRes6JHhl5khp1') {
          showTicket();
        } else
          return;
      } else if (this.mounted)
        setState(() {
          initCount = 1;
        });
    });
  }

  void showTicket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0x00757575),
        content: TicketView(
          backgroundColor: Color(0x00757575),
          child: Container(
            height: 130.0,
            width: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Time ",
                ),
                Text(TimeOfDay.now().format(context)),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  height: 2.0,
                  color: Colors.black,
                  endIndent: 69.0,
                  indent: 40.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Tariff"),
                Text(tariff),
              ],
            ),
          ),
        ),
      ),
    ).then((value) {
      if (value == null) Navigator.pushReplacementNamed(context, MainScreen.id);
    });
  }

  void checkParked() {
    DatabaseReference newRef = FirebaseDatabase.instance
        .reference()
        .child('parkedUsers')
        .child('GasfCqudf8WTuDzRes6JHhl5khp1');
    newRef.once().then((DataSnapshot snap) {
      if (snap.value != null) {
        dynamicDialog(context, 'Parked', "You have already parked")
            .whenComplete(
          () => Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.id, (route) => false),
        );
        getParked();
      } else
        getParked();
    });
  }

  @override
  void initState() {
    checkSlots();
    checkParked();
    getTarrif();
    super.initState();
  }

  @override
  void dispose() {
    if (this.mounted) {
      subscription.cancel();
      initCount = 0;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                      'Park Car',
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
              Container(
                padding: EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 30.0,
                  bottom: 30.0,
                ),
                child: QrImage(data: 'UserId'),
              ),
              Text(
                'Please scan this QR code to Authenticate',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ]),
      ),
    );
  }
}
