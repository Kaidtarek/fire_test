import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm(
      {super.key, required this.myController, required this.hintTitle});
  TextEditingController myController = TextEditingController();
  final String hintTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(hintTitle[0].toUpperCase() + hintTitle.substring(1),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
        TextFormField(
          controller: myController,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              hintText: 'enter your $hintTitle ',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              filled: true,
              fillColor: Colors.grey[300]),
        ),
      ],
    );
  }
}
