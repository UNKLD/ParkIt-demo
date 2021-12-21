import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  RoundedButton(this.title, this.onPressed);
  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.blueAccent,
        elevation: 8.0,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}