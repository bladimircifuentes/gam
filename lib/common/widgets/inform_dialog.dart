import 'package:flutter/material.dart';
import 'package:gam/common/widgets/widgets.dart';

class InformDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onPressed;

  const InformDialog({
    super.key, 
    required this.title,
    required this.content,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
      ),
      title: Text(title,textAlign: TextAlign.center),
      content: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Los botones ocuparán todo el ancho
          children: [
            Text(content, textAlign: TextAlign.center,),
            const SizedBox(height: 16), // Espacio entre el texto y los botones
            CustomButton(
              texto: 'OK', 
              onPressed: () {
                Navigator.pop(context);
                onPressed();
              }, 
              color: Colors.green
            ),
          ],
        ),
      ),
    );
  }
}