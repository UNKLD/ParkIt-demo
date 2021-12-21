import 'package:flutter/material.dart';

Future dynamicDialog(BuildContext context, String title, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(
        message,
        style: TextStyle(
          fontSize: 15.5,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
