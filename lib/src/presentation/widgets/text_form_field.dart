import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const AppTextFormField({
    Key? key,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.onTap,
    this.errorText,
    this.obscureText = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        textInputAction: textInputAction,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          errorText: errorText,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: prefixIcon,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        ),
        onTap: onTap);
  }
}
