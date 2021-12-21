import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/dynamicDialog.dart';
import 'package:untitled/screens/mainScreen.dart';

class UpdateReserve extends StatefulWidget {
  @override
  _UpdateReserveState createState() => _UpdateReserveState();
}

class _UpdateReserveState extends State<UpdateReserve> {
  String _selectedTime = '';
  String id = '';
  final databaseRef =
      FirebaseDatabase.instance.reference().child('reservations');

  @override
  void initState() {
    super.initState();
    hasReserved();
  }

  void updateReservation() {
    DatabaseReference newRef = databaseRef.child(id);
    newRef.update({
      'time': _selectedTime,
    }).onError(
      (error, stackTrace) => print(error),
    );
    dynamicDialog(context, 'Done', 'Update Successfull');
  }

  Future<void> _show() async {
    final TimeOfDay result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      if (TimeOfDay.now().format(context) == result.format(context))
        print("Cannot select current time");
      else
        setState(() {
          _selectedTime = result.format(context);
        });
    }
  }

  void hasReserved() {
    databaseRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) if (this.mounted)
        for (var value in snapshot.value.values) {
          if (value['user'] == 'currentUserId') {
            setState(() {
              id = value['id'];
              _selectedTime = value['time'];
            });
          }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                child: Text(
                  'Active Reservation',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   height: 100.0,
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(15.0),
                //   ),
                //   child: Center(
                //     child: Text(
                //       'Update 1hour before arrival time',
                //       style: TextStyle(
                //         fontSize: 20.5,
                //         color: Colors.black54,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
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
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(20, 50),
                          ),
                          onPressed: () {
                            //Submit reservation
                            if (_selectedTime != '')
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Are you sure?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value == null) return;
                                if (value) {
                                  updateReservation();
                                } else
                                  return;
                              });
                          },
                          child: Text('Update'),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            minimumSize: Size(20, 50),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Are you sure?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                ],
                              ),
                            ).then((value) {
                              if (value == null) return;
                              if (value) {
                                DatabaseReference newRef =
                                    databaseRef.child(id);
                                newRef.remove();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, MainScreen.id, (route) => false);
                              } else
                                return;
                            });
                          },
                          child: Text(
                            'Cancel',
                          ),
                        ),
                      ),
                    ],
                  ),
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
