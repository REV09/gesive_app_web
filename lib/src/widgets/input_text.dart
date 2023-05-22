import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String label;
  final bool borderEnabled;
  final double fontSize;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  const InputText({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    required this.fontSize,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle emailAdressLabel = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: fontSize);

    TextStyle textFieldStyleFont = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: fontSize + 3);

    InputDecoration emailAdressDecoration = InputDecoration(
        labelText: label,
        labelStyle: emailAdressLabel,
        border: borderEnabled ? null : InputBorder.none);
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: emailAdressDecoration,
      style: textFieldStyleFont,
    );
  }
}
