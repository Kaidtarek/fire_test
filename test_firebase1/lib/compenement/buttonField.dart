// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Custombuttonauth extends StatelessWidget {
  const Custombuttonauth({
    Key? key,
    required this.title,
    this.onpressed,
  }) : super(key: key);
final String title;
final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
            onPressed: onpressed ,
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            color: Colors.orange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            height: 50,
          );
  }
}
