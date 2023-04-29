import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color buttonColor;
  final String textOfButton;
  final Color textColor;
  final Function()? onTapped;

  const MyButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.textOfButton,
    required this.onTapped,
  });
  //

  //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        // when button clicks
        onTap: onTapped,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: buttonColor,
          ),
          child: Center(
            child: Text(
              textOfButton,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
