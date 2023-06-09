import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Text text;
  final VoidCallback ontap;
  final Color? color;
  final double? borderRadius;

   PrimaryButton({Key? key, required this.text,  required this.ontap, this.color, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color ?? Color(0xff1152FD)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 15),
              side: BorderSide(color: color ?? Color(0xff1152FD),width: 0.5)
          ),
        ),
      ),
      child: text,
      onPressed: ontap,
    );
  }
}
