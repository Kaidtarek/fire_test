import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.name,
      required this.onPressed,
      required this.my_color,
      this.ihaveImage});
  final String name;
  final String? ihaveImage;
  final Function()? onPressed;
  final Color my_color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: MaterialButton(
        color: my_color,
        height: 50,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$name  ',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            ihaveImage != null
                ? Image.asset(
                    ihaveImage.toString(),
                    height: 10,
                  )
                : Container(),
            
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
      ),
    );
  }
}
