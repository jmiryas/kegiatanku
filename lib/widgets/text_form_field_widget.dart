import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.hint,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(controller.text),
      controller: controller,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          )),
      onSaved: (String? value) {},
      validator: (String? value) {
        return value!.isEmpty ? "Tidak boleh kosong" : null;
      },
    );
  }
}
