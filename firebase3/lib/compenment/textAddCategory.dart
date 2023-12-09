import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomTextFormAdd extends StatefulWidget {
  CustomTextFormAdd(
      {super.key, required this.myController, required this.hintTitle});
  TextEditingController myController = TextEditingController();
  final String hintTitle;

  @override
  State<CustomTextFormAdd> createState() => _CustomTextFormAddState();
}

class _CustomTextFormAddState extends State<CustomTextFormAdd> {
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(widget.hintTitle[0].toUpperCase() + widget.hintTitle.substring(1),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
        TextFormField(
          controller: widget.myController,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              hintText: 'enter your ${widget.hintTitle} ',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              filled: true,
              fillColor: Colors.grey[300]),
        ),
      ],
    );
  }
}
