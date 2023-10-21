import 'package:flutter/material.dart';
import 'package:gam/chat/services/auth_chat_service.dart';
import 'package:gam/chat/services/socket_chat_service.dart';
import 'package:gam/common/global/environment_provider.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final environmentProvider = context.read<EnvironmentProvider>();
    final profileProvider     = context.read<ProfileProvider>();
    final authChatService     = context.read<AuthChatService>();
    final socketChatService   = context.read<SocketChatService>();

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
            debugPrint('ON PRESSED TEACHER PAGE');

            int id = profileProvider.usuario!.id;
            String apiUrl = environmentProvider.apiUrl;

            debugPrint('ID: $id');
            debugPrint('API URL: $apiUrl');

            final loggedUserChat = await authChatService.loggedInUserChat(id, apiUrl);

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