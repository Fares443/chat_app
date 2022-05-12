import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyButton(
      {required this.color, required this.title, required this.onPressed});
  final Color color;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
          elevation: 5,
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          child: MaterialButton(
            onPressed: onPressed,
            height: 42,
            minWidth: double.infinity,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
