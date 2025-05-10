import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.onPressed, required this.label});

  final Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed, child: Text(label));
  }
}
