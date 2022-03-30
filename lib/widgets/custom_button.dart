import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const CustomButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      child: ElevatedButton(
        onPressed: onTap(),
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
