import 'package:flutter/material.dart';
import 'package:gam/common/widgets/widgets.dart';
import 'package:gam/login/providers/providers.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profile, child) {
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
                    onPressed: () async {

                      bool result = await showDialog(
                        context: context, 
                        builder: (context) => const ConfirmationDialog(
                          title: 'Cerrar Sesión', 
                          content: '¿Desea Continuar?'
                        ),
                      );

                      if(context.mounted && result){
                        
                        await context.read<AuthProvider>().logout();
                        if(context.mounted){
                          await context.read<ProfileProvider>().checkProfile();
                          if(context.mounted){
                            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                          }
                          
                        }
                      }
                    },
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(userInformation(profile.getProfileData()))
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, 'settings'),
            backgroundColor: Colors.blue,
            child: const Icon(Icons.settings),
          ),
        );
      },
    );
  }

  List<Widget> userInformation(Map<String, dynamic> user) {
    List<Widget> widgets = [];

    user.forEach((key, value) {
      
      value = value.runtimeType.toString() == 'String'
        ? value
        : value.toString();

      widgets.add(
        ListTile(
          leading: _getIcon(key),
          title: Text(key),
          subtitle: Text(value),
        )
      );

    });

    return widgets;
  }
  Icon _getIcon(String field){

    Map<String, String> keys = {
      'Carnet': 'carnet',
      'Nombres': 'name',
      'Apellidos': 'last_name',
      'Correo electronico': 'email',
      'Fecha de nacimiento': 'birthdate',
      'Teléfono': 'phone',
      'Dirección': 'address',
      'CUI': 'cui',
      'Grado': 'grade',
    };
    
    String icon = keys[field] ?? '';

    Map<String, Icon> icons = {
      'carnet': const Icon(Icons.card_membership_outlined),
      'name': const Icon(Icons.person_outline),
      'last_name': const Icon(Icons.person_outline),
      'email': const Icon(Icons.email_outlined),
      'birthdate': const Icon(Icons.cake_outlined),
      'phone': const Icon(Icons.phone_outlined),
      'address': const Icon(Icons.pin_drop_outlined),
      'cui': const Icon(Icons.fingerprint_outlined),
      'grade': const Icon(Icons.school_outlined)
    };

    return icons[icon] ?? const Icon(Icons.warning);
  }
}
