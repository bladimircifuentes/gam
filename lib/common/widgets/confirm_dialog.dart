import 'package:gam/common/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;

  const ConfirmationDialog({
    super.key, 
    required this.title,
    required this.content,
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
              texto: 'Si', 
              onPressed: () {
                Navigator.of(context).pop(true); // Pop con valor 'true' para indicar respuesta afirmativa
              }, 
              color: Colors.green
            ),
            CustomButton(
              texto: 'No', 
              onPressed: () {
                Navigator.of(context).pop(false); // Pop con valor 'false' para indicar respuesta negativa
              }, 
              color: Colors.red
            ),
          ],
        ),
      ),
    );
  }
}
