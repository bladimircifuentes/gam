import 'package:gam/chat/models/message_chat_model.dart';

class ChatModel {
  final String type;
  final String name;
  final String description;
  final List<MessageChatModel> messages;

  ChatModel({
    required this.type,
    required this.name,
    required this.messages,
    required this.description,
  });
}
