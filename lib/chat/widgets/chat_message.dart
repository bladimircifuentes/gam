import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gam/chat/services/auth_chat_service.dart';

class ChatMessage extends StatelessWidget {
  final int id;
  final String message;
  final String type = 'txt';
  final String date;

  const ChatMessage({super.key, required this.id, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    final authChatService =
        Provider.of<AuthChatService>(context, listen: false);
    return Container(
      child: id == authChatService.userChat!.id
          ? _myMessage(context)
          : _notMyMessage(context),
    );
  }

  Widget _myMessage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(79, 195, 247, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _message(context),
      ),
    );
  }

  Widget _message(BuildContext context) {
    Widget content = Container();
    if (type == 'doc') {}
    if (type == 'txt') {
      content = Text(
        message,
        style: const TextStyle(color: Colors.black),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        content,
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              date,
              style: const TextStyle(fontSize: 10, color: Colors.black45),
            ),
            const SizedBox(width: 5),
            // if (Provider.of<Auth>(context).logged.id == id)
            //   const Icon(Icons.check, size: 14)
          ],
        )
      ],
    );
  }

  Widget _notMyMessage(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 50),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(224, 224, 224, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _message(context),
      ),
    );
  }
}
