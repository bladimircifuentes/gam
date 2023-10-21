import 'package:flutter/material.dart';

class ShowExpandableInformation extends StatelessWidget {
  final String titulo;
  final String contenido;
  const ShowExpandableInformation({
    super.key, 
    required this.titulo, 
    required this.contenido
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold 
          ), 
        ),
        Text(
          contenido
        ),
      ],
    );
  }
}