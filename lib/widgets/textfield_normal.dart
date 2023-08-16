import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.icon,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            hintText: hintText,
            labelText: labelText),
      ),
    );
  }
}
