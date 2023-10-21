import 'package:flutter/material.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Studen page'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'profile'), 
            icon: const Icon(Icons.person_pin)
          )
        ],
      ),
      body: const Center(
        child: Text('Studen page'),
      ),
    );
  }
}