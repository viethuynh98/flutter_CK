import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.isPassword = false,
      this.isReadOnly = false,
      this.prefixIcon,
      this.action = TextInputAction.next,
      this.inputType});

  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final bool isReadOnly;
  final Icon? prefixIcon;
  final TextInputAction action;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        obscureText: isPassword,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          prefixIconConstraints: const BoxConstraints(minWidth: 30.0),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        textInputAction: action,
      ),
    );
  }
}
