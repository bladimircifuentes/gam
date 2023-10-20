import 'package:flutter/material.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Teacher page'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.person_pin)
          )
        ],
      ),
      body: const Center(
        child: Text('Teacher page'),
      ),
    );
  }
}