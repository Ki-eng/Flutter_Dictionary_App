import 'package:dictionary_app/constants/appStrings.dart';
import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  CustomTextfieldWidget({required this.onChange, this.controller});

  final void Function(String) onChange;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        onChanged: onChange,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          icon: Icon(
            Icons.text_fields,
            size: 30,
            color: Colors.white,
          ),
          hintText: Appstrings.hintText,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
