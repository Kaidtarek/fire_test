// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFoorm extends StatelessWidget {
  CustomTextFoorm({
    Key? key,
    required this.hintText,
    required this.myController,
  }) : super(key: key);
   TextEditingController myController = TextEditingController();
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          hintText: 'Enter your $hintText',
          hintStyle: TextStyle(fontSize: 14),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          fillColor: Colors.grey[200],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )),
    );
  }
}
