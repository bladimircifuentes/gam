import 'package:flutter/material.dart';

class ElementContainer extends StatelessWidget {
  final List<Widget> elements;
  final CrossAxisAlignment crossAxisAlignment;
  const ElementContainer({
    super.key, 
    required this.elements,
    this.crossAxisAlignment =CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: MainAxisAlignment.center,
          children: elements
        ),
      ),
    );
  }
}