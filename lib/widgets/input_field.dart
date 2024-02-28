import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.icon,
      required this.hint,
      required this.obscure});

  final IconData icon;
  final String hint;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pinkAccent,
          ),
        ),
        contentPadding: const EdgeInsets.only(
          left: 5,
          right: 30,
          bottom: 30,
          top: 30,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      obscureText: obscure,
    );
  }
}
