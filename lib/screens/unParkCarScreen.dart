import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticketview/ticketview.dart';
import 'package:untitled/components/dynamicDialog.dart';
import 'package:untitled/screens/mainScreen.dart';

class UnParkCarScreen extends StatefulWidget {
  static const id = "unParkCarScreen";

  @override
  _UnParkCarScreenState createState() => _UnParkCarScreenState();
}

class _UnParkCarScreenState extends State<UnParkCarScreen> {
  var subscription;
  String tariff = '';
  int initCount = 0;
  final databaseRef =
      FirebaseDatabase.instance.reference().child('parkedUsers');

  void checkParked() {
    databaseRef
        .child('GasfCqudf8WTuDzRes6JHhl5khp1')
        .once()
        .then((DataSnapshot snap) {
      if (snap.value == null) {
        dynamicDialog(context, 'Please Park', "You have not parked yet")
            .whenComplete(
          () => Navigator.pushReplacementNamed(context, MainScreen.id),
        );
        getParked();
      } else
        getParked();
    });
  }

  void getParked() {
    subscription = databaseRef.onChildRemoved.listen((data) {
      // print(data.snapshot.value['id']);
      if (data.snapshot.value['id'] == "GasfCqudf8WTuDzRes6JHhl5khp1")
        calculateTotal(data.snapshot.value['time'].toString());
    });
  }

  void calculateTotal(String s) {
    String now = TimeOfDay.now().format(context);

    TimeOfDay parkedTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]),
        minute: int.parse(s.split(":")[1].split(" ")[0]));

    TimeOfDay nowTime = TimeOfDay(
        hour: int.parse(now.split(":")[0]),
        minute: int.parse(now.split(":")[1].split(" ")[0]));

    int _hour = (nowTime.hour - parkedTime.hour);
    String total = (_hour * double.parse(tariff)).toString();

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
                Text(
                  "Amount = $total",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 9.0,
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
                    paymentReport(context, total);
                    showDialog(
                      context: context,
                      builder: (context) => ReciptWidget(
                        tariff: double.parse(tariff),
                        total: total,
                      ),
                    ).then((value) {
                      if (value == null || value) {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, MainScreen.id, (route) => false);
                      } else
                        return;
                    });
                  },
                  child: Text('Submit'),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void paymentReport(BuildContext context, String total) {
    DatabaseReference newRef =
        FirebaseDatabase.instance.reference().child('payment').push();
    String newKey = newRef.key;
    newRef.set({
      'id': newKey,
      'method': "Paypal",
      'amount': total,
      'user': 'currentUserId',
      'time': TimeOfDay.now().format(context),
    }).onError(
      (error, stackTrace) => print(error),
    );
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

  @override
  void initState() {
    super.initState();
    checkParked();
    getTarrif();
    //if Current user is not in parked users db Navigate and toast
  }

  @override
  void dispose() {
    if (this.mounted) subscription.cancel();
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
                      'Unpark Car',
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
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                child: QrImage(data: 'GasfCqudf8WTuDzRes6JHhl5khp1'),
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

class ReciptWidget extends StatelessWidget {
  final double tariff;
  final String total;

  const ReciptWidget({this.tariff, this.total}) : super();
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
                      'Total = ' + total + " Birr",
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
                        data: "Total: " + total + "user: " + "userId",
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
