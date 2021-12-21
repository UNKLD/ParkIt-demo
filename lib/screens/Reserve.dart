import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled/components/dynamicDialog.dart';
import 'package:untitled/screens/mainScreen.dart';
import 'package:ticketview/ticketview.dart';

class Reserve extends StatefulWidget {
  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  String _selectedTime = '';
  int waitTime = 30;
  bool chValue = false;
  bool hasReserved = false;
  bool isParked = false;
  var tariff;
  FirebaseAuth auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.reference();

  void reserveNow() {
    DatabaseReference newRef =
        databaseRef.child('reservations').child('userId');
    newRef.set({
      'id': auth.currentUser.uid,
      'time': _selectedTime,
      'userEmail': auth.currentUser.email,
    }).onError(
      (error, stackTrace) => print(error),
    );
  }

  void report(BuildContext context) {
    final newRef = FirebaseDatabase.instance.reference().child('report').push();
    String newKey = newRef.key;
    newRef.set({
      'id': newKey,
      'report': 'reserve'
      'userEmail': auth.currentUser.email,
      'time': TimeOfDay.now().format(context),
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  void paymentReport(BuildContext context) {
    DatabaseReference newRef = databaseRef.child('payment').push();
    String newKey = newRef.key;
    newRef.set({
      'id': newKey,
      'method': "Paypal",
      'amount': tariff,
      'user': auth.currentUser.uid,
      'time': TimeOfDay.now().format(context),
    }).onError(
      (error, stackTrace) => print(error),
    );
  }

  void checkParked() {
    databaseRef
        .child('parkedUsers')
        .child('GasfCqudf8WTuDzRes6JHhl5khp1')
        .once()
        .then((DataSnapshot snap) {
      if (snap.value != null) {
        dynamicDialog(context, 'Parked', "You have already parked")
            .whenComplete(
          () => Navigator.pushReplacementNamed(context, MainScreen.id),
        );
      } else
        return;
    });
  }

  Future<void> _show() async {
    final TimeOfDay result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      if (TimeOfDay.now().format(context) == result.format(context))
        dynamicDialog(context, "Error", "Cannot select current time");
      else
        setState(() {
          _selectedTime = result.format(context);
        });
    }
  }

  void getTarrif() {
    databaseRef.child('tariff').once().then((value) {
      if (value != null && this.mounted)
        setState(() {
          tariff = value.value['amount'];
        });
    });
  }

  @override
  void initState() {
    super.initState();
    getTarrif();
    checkParked();
  }

  @override
  Widget build(BuildContext context) {
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
                heightFactor: 100.0,
                child: Text(
                  'Reservation',
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
              children: <Widget>[
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'Tariff = ' + (tariff != null ? tariff : 'Loading..'),
                      style: TextStyle(
                        fontSize: 20.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        _show();
                      },
                      leading: Text(
                        'Reserve Time:  ',
                        style: TextStyle(
                          fontSize: 16.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        _selectedTime != '' ? _selectedTime : 'Tap to select!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(20, 50.0),
                  ),
                  onPressed: () {
                    //Submit reservation
                    if (_selectedTime == '') {
                      dynamicDialog(
                          context, "Error", "Please select Time first");
                    } else {
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    'Choose Payment option',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.payment),
                                    title: Text('Paypal'),
                                    trailing: Checkbox(
                                      value: true,
                                      onChanged: (newValue) {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(20, 50.0),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => ReciptWidget(
                                          tariff: double.parse(tariff),
                                        ),
                                      ).then((value) {
                                        if (value == null || value) {
                                          Navigator.pop(context);
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              MainScreen.id,
                                              (route) => false);
                                          reserveNow();
                                          paymentReport(context);
                                          report(context);
                                        } else
                                          return;
                                      });
                                    },
                                    child: Text('Submit'),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      minimumSize: Size(20, 50),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _selectedTime = '';
    super.dispose();
  }
}

class ReciptWidget extends StatelessWidget {
  final double tariff;

  const ReciptWidget({this.tariff}) : super();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: Color(0x00757575),
      content: TicketView(
        backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        backgroundColor: Color(0xFF8F1299),
        contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        drawArc: false,
        triangleAxis: Axis.vertical,
        borderRadius: 6,
        drawDivider: true,
        trianglePos: .5,
        child: Container(
          height: 500.0,
          width: 400.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  fontSize: 33.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tariff = $tariff',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Total = ' + tariff.toString() + " Birr",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.0, top: 0.0),
                child: Column(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      child: QrImage(
                        data:
                            "Total: " + tariff.toString() + "user: " + "userId",
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          'Confirm',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
