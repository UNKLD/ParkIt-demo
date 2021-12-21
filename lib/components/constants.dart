import 'package:flutter/material.dart';

const KinputDecoration = InputDecoration(
  labelStyle: TextStyle(fontSize: 18.0),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.cyan,
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 1.5,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

const KinfoTextDecoration = TextStyle(
  fontSize: 20.0,
  letterSpacing: 1.5,
);
