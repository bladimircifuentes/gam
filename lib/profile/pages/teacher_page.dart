import 'package:flutter/material.dart';
import 'package:gam/chat/services/auth_chat_service.dart';
import 'package:gam/chat/services/socket_chat_service.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService       = Provider.of<ProfileProvider>(context);
    final authChatService   = Provider.of<AuthChatService>(context);
    final socketChatService = Provider.of<SocketChatService>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Teacher page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('profile');
            }, 
            icon: const Icon(Icons.person_pin)
          )
        ],
      ),
      body: const Center(
        child: Text('Teacher page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            debugPrint('ID: ${authService.usuario!.id}');

            final loggedUserChat = await authChatService
              .loggedInUserChat(authService.usuario!.id);

            if(loggedUserChat) {
              socketChatService.connect();
              await authChatService.userChatContacts(false);

              if(context.mounted) {
                Navigator.of(context).pushNamed('contacts');
              }
            } else {
              throw Exception();
            }
          } catch(e) {
            if(context.mounted) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                title: const Text('La conexion al chat ha fallado'),
                content: const Text('Ha ocurrido un error comuniquese son soporte tecnico'),
                actions: [
                    MaterialButton(
                      elevation: 5,
                      textColor: Colors.blue,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('ok'),
                    ),
                  ],
                ),
              );
            }
          }
        },
        child: const Icon(Icons.messenger),
      ),
    );
  }
}