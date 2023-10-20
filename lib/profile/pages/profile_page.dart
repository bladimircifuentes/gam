import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Person().toMap();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Perfil'),
              background: FittedBox(
                fit: BoxFit.cover,
                child: Icon(
                  Icons.person,
                  color: Colors.black26,
                ),

                // child: Image(
                //   fit: BoxFit.cover,
                //   image: NetworkImage('url'),
                //   errorBuilder: (context, error, stackTrace) => Text('error'),
                // )
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(userInformation(user))
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.settings),
      ),
    );
  }

  List<Widget> userInformation(Map<String, dynamic> user) {
    List<Widget> widgets = [];
    Map<String, IconData> icons = {
      'carnet': Icons.card_membership_outlined,
      'name': Icons.person_outline,
      'last_name': Icons.person_outline,
      'email': Icons.email_outlined,
      'birthdate': Icons.cake_outlined,
      'phone': Icons.phone_outlined,
      'address': Icons.pin_drop_outlined,
      'cui': Icons.fingerprint_outlined,
      'grade': Icons.school_outlined
    };
    Map<String, String> keys = {
      'carnet': 'Carnet',
      'name': 'Nombres',
      'last_name': 'Apellidos',
      'email': 'Correo electronico',
      'birthdate': 'Fecha de nacimiento',
      'phone': 'Teléfono',
      'address': 'Dirección',
      'cui': 'CUI',
      'grade': 'Grado'
    };

    user.forEach((key, value) {
      if(key.isNotEmpty && value != null) {
        value = value.runtimeType.toString() == 'String'
          ? value
          : value.toString();

        widgets.add(
          ListTile(
            leading: Icon(icons[key]),
            title: Text(keys[key]!),
            subtitle: Text(value),
          )
        );
      }
    });

    return widgets;
  }
}

class Person {
  String carnet = '2017060300006';
  String name = 'Nombre';
  String lastName = 'Apellido';
  String email = 'test@correo.com';
  DateTime birthdate = DateTime.parse('2000-03-20');
  String phone = '56213948';
  String address = '5ta. Calle';
  String cui = '1953324741001';
  String? grado;

  Person();

  Map<String, dynamic> toMap() {
    return {
      'carnet': carnet,
      'name': name,
      'last_name': lastName,
      'email': email,
      'birthdate': birthdate,
      'phone': phone,
      'address': address,
      'cui': cui,
      'grade': grado
    };
  }
}
