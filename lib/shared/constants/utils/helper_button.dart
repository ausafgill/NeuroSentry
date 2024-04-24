import 'package:flutter/material.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';

class HelperButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final Color? color;
  const HelperButton(
      {super.key, required this.name, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color ?? EColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
