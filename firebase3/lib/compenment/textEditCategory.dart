import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomTextFormEdit extends StatefulWidget {
  final String oldName2;
  CustomTextFormEdit(
      {super.key, required this.myController, required this.oldName2});
  TextEditingController myController = TextEditingController();

  @override
  State<CustomTextFormEdit> createState() => _CustomTextFormEditState();
}

class _CustomTextFormEditState extends State<CustomTextFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text('Edit',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
        SizedBox(height: 5),
        TextFormField(
          controller: widget.myController,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              hintText: '${widget.oldName2}',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              filled: true,
              fillColor: Colors.grey[300]),
        ),
      ],
    );
  }
}
