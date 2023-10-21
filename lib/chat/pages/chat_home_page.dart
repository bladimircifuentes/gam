import 'package:flutter/material.dart';
import 'package:gam/chat/models/models.dart';
import 'package:gam/chat/pages/pages.dart';
import 'package:gam/chat/services/services.dart';
import 'package:gam/common/global/environment_provider.dart';
import 'package:provider/provider.dart';


class ChatHomePage extends StatelessWidget {
  final List<MessageChatModel> mensajesSingle = [];

  ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final environmentProvider = context.read<EnvironmentProvider>();
    final authChatService = Provider.of<AuthChatService>(context);
    final socketChatService = Provider.of<SocketChatService>(context);
    List<ChatModel> chats = [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            socketChatService.disconnect();
          },
        ),
        centerTitle: true,
        title: const Text('Chats'),
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: (socketChatService.serverStatus == ServerStatus.online)
                ? const Icon(Icons.check_circle)
                : const Icon(Icons.cancel),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ChatCursos(chats: chats),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await authChatService.userChatContacts(false, environmentProvider.apiUrl);
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ListContactPage()),
            );
          }
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}

class ChatCursos extends StatelessWidget {
  final List<ChatModel> chats;

  const ChatCursos({Key? key, required this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: chats.length,
      itemBuilder: (_, i) {
        final chat = chats[i];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatPage(title: chat.name, chatType: chat.type),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[400],
              child: _Tipochat(chats[i].type),
            ),
            title: Text(chats[i].name),
            subtitle: Text(chats[i].description),
          ),
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Icon _Tipochat(String type) {
    if (type == 'group') {
      return const Icon(
        Icons.group,
        color: Colors.white,
      );
    }
    return const Icon(
      Icons.person,
      color: Colors.white,
    );
  }
}
