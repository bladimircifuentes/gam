import 'package:flutter/material.dart';
import 'package:gam/chat/services/auth_chat_service.dart';
import 'package:gam/chat/services/socket_chat_service.dart';
import 'package:gam/common/global/environment_provider.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final environmentProvider = context.read<EnvironmentProvider>();
    final authService       = context.read<ProfileProvider>();
    final authChatService   = context.read<AuthChatService>();
    final socketChatService = context.read<SocketChatService>();
    
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            debugPrint('ID: ${authService.usuario!.id}');

            final loggedUserChat = await authChatService
              .loggedInUserChat(authService.usuario!.id, environmentProvider.apiUrl);

            if(loggedUserChat) {
              socketChatService.connect(environmentProvider.socketUrl);
              await authChatService.userChatContacts(false, environmentProvider.apiUrl);

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
