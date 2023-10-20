import 'package:flutter/material.dart';

class BtnBlue extends StatelessWidget {

  final String texto;
  final Function()? onPressed;

  const BtnBlue({
    super.key, 
    required this.texto, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Colors.blue,
          shape: const StadiumBorder()
        ),
        onPressed: onPressed,
        child:  SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
            child:  Text(texto)
          )
        )
      ),
    );
  }
}