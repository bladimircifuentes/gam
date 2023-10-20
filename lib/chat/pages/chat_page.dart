import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:gam/chat/models/message_chat.dart';
import 'package:gam/chat/services/auth_chat_service.dart';
import 'package:gam/chat/services/chat_service.dart';
import 'package:gam/chat/services/message_chat_service.dart';
import 'package:gam/chat/services/socket_chat_service.dart';
import 'package:gam/chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String chatType;

  const ChatPage({super.key, this.title = '', this.chatType = ''});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  AuthChatService? authChatService;
  SocketChatService? socketChatService;
  ChatService? chatService;

  bool _estaEscribiendo = false;
  final _textController = TextEditingController();
  late final ScrollController _scrollController;
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  late bool hasMore;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketChatService = Provider.of<SocketChatService>(context, listen: false);
    authChatService = Provider.of<AuthChatService>(context, listen: false);

    _scrollController = ScrollController();
    _scrollController.addListener(_infiniteScrolling);

    socketChatService!.socket.on('personal-message', _listenMessage);
    _loadHistory(authChatService!.userChat!.id, chatService!.contactFor!.id);
    hasMore = true;
  }

  void _infiniteScrolling() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        hasMore) {
      _loadHistory(authChatService!.userChat!.id, chatService!.contactFor!.id);
    }
  }

  void _listenMessage(dynamic payload) {
    if (payload['from'] != chatService!.contactFor!.id) return;

    DateTime createdAt = DateTime.parse(payload['created_at']);

    ChatMessage message = ChatMessage(
      id: payload['from'],
      message: payload['content'],
      date: timeago.format(createdAt, locale: 'es'),
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  void _loadHistory(int userFromID, int userToID) async {
    final chat = await chatService!.getChat(userFromID, userToID);

    if (chat.isNotEmpty) {
      List<ChatMessage> history = chat
          .map((m) => ChatMessage(
              id: m.from,
              message: m.content,
              date: timeago.format(m.createdAt!, locale: 'es')))
          .toList();
      history = [..._messages, ...history];
      setState(() {
        _messages.clear();
        _messages.insertAll(0, history);
      });

      if (chat.length < 30) {
        setState(() {
          hasMore = false;
        });
        chatService!.cursor = 0;
      }
    }

    if (chat.isEmpty) {
      setState(() {
        hasMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _messages.clear();
        chatService!.cursor = 0;
        setState(() {
          hasMore = true;
        });
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: _encabezado(),
            elevation: 1,
          ),
          body: Column(children: [
            Flexible(
              child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: hasMore ? _messages.length + 1 : _messages.length,
                  itemBuilder: (_, i) {
                    if (i < _messages.length) {
                      return _messages[i];
                    } else {
                      return Center(
                        child: hasMore
                            ? const CircularProgressIndicator()
                            : const SizedBox(),
                      );
                    }
                  }),
            ),
            Card(
              child: _inputChat(),
            )
          ])),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              maxLines: 3,
              minLines: 1,
              controller: _textController,
              onSubmitted: _estaEscribiendo ? _handelSubmit : null,
              onChanged: (texto) {
                setState(() {
                  if (texto.trim().isNotEmpty) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Enviar mensaje',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
              focusNode: _focusNode,
            ),
          ),
          IconButton(
            color: Colors.blue[400],
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.send),
            onPressed: _estaEscribiendo
                ? () => _handelSubmit(_textController.text.trim())
                : null,
          ),
        ],
      ),
    ));
  }

  _handelSubmit(String texto) {
    _textController.clear();
    _focusNode.requestFocus();

    _newMessage(texto, 'txt');
  }

  Widget _encabezado() {
    Icon iconChat = const Icon(Icons.person, color: Colors.white);

    if (widget.chatType == 'group') {
      iconChat = const Icon(Icons.group, color: Colors.white);
    }

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[400],
          child: iconChat,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16),
            ),
            if (widget.chatType == 'group')
              const Text('10 participantes', style: TextStyle(fontSize: 12))
          ]),
        ),
      ],
    );
  }

  void _newMessage(String message, String tipo) async {
    final messageChatService =
        Provider.of<MessageChatService>(context, listen: false);
    final messageChat = MessageChat(
        from: authChatService!.userChat!.id,
        to: chatService!.contactFor!.id,
        content: message);

    final savedMessage =
        await messageChatService.saveMessage(messageChatToJson(messageChat));

    if (savedMessage == null) {
      return;
    }

    if (tipo != 'txt') {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }

    if (mounted) {
      setState(() {
        _messages.insert(
            0,
            ChatMessage(
              id: savedMessage.from,
              message: savedMessage.content,
              date: timeago.format(savedMessage.createdAt!, locale: 'es'),
            ));
        _estaEscribiendo = false;
      });
    }

    socketChatService!.socket.emit('personal-message', savedMessage);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    socketChatService!.socket.off('personal-message');
  }
}
