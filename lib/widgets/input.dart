import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    this.label,
    this.type = InputType.oneLine,
    this.onEdit,
    this.controller,
    this.hintText = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);
  final String? label;
  final InputType type;
  final Function(String)? onEdit;
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TextFormField(
        maxLines: type == InputType.oneLine ? 1 : 50,
        onChanged: onEdit,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, hintText: hintText, hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey)),
      ),
    );
  }
}

enum InputType { oneLine, multiLine }
