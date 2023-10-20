import 'package:gam/chat/models/message_chat.dart';

class Chat {
  final String type;
  final String name;
  final String description;
  final List<MessageChat> messages;

  Chat({
    required this.type,
    required this.name,
    required this.messages,
    required this.description,
  });
}
