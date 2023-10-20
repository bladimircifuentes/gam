import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String texto;
  final void Function() onPressed;
  final Color color;
  const CustomButton({
    super.key,
    required this.texto, 
    required this.onPressed,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: color,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ), 
      child: Text(
        texto
      )
    );
  }
}