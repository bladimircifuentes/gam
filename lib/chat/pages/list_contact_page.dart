import 'package:flutter/material.dart';
import 'package:gam/common/global/environment_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:gam/chat/models/models.dart';
import 'package:gam/chat/pages/pages.dart';
import 'package:gam/chat/services/services.dart';
import 'package:gam/chat/search/contact_search_delegate.dart';

class ListContactPage extends StatefulWidget {
  const ListContactPage({super.key});

  @override
  State<ListContactPage> createState() => _ListContactPageState();
}

class _ListContactPageState extends State<ListContactPage> {
  final RefreshController _refreshController =
    RefreshController(initialRefresh: false);
  late final SocketChatService socketChatService;
  late final AuthChatService authChatService;
  late EnvironmentProvider environmentProvider;
  List<ContactChatModel> _contacts = [];
  int _numberOfContacts = 0;

  @override
  void initState() {
    super.initState();
    environmentProvider = context.read<EnvironmentProvider>();
    authChatService = Provider.of<AuthChatService>(context, listen: false);
    socketChatService = Provider.of<SocketChatService>(context, listen: false);
    _contacts = authChatService.contacts!;
    _numberOfContacts = _contacts.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            socketChatService.disconnect();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contacto${_numberOfContacts != 1 ? 's' : ''}'),
            Text(
              '$_numberOfContacts contacto${_numberOfContacts != 1 ? 's' : ''}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(contacts: _contacts),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
            padding: const EdgeInsets.only(right: 8),
          ),
        ],
        elevation: 0,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () {
          _loadContacts();
        },
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue,
        ),
        child: listViewContacts(context),
      ),
    );
  }

  ListView listViewContacts(BuildContext context) {
    return ListView.builder(
      itemCount: _numberOfContacts,
      itemBuilder: (_, i) {
        final contact = _contacts[i];
        return GestureDetector(
          onTap: () {
            final chatService =
              Provider.of<ChatService>(context, listen: false);
            chatService.contactFor = contact;

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                  ChatPage(title: contact.firstName, chatType: 'Single'),
              ),
            );
          },
          child: _contactListTile(contact),
        );
      },
    );
  }

  ListTile _contactListTile(ContactChatModel contact) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[400],
        child: const Icon(Icons.person, color: Colors.white),
      ),
      title: _infoContact(contact),
      trailing: Icon(
        Icons.messenger,
        color: (contact.online == 1) ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _infoContact(ContactChatModel contact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: detailsContact(contact),
    );
  }

  List<Widget> detailsContact(ContactChatModel contact) {
    List<Widget> details = [];
    details.addAll([
      Text(contact.firstName),
      Text(
        '${contact.grade} "${contact.section}"',
        style: const TextStyle(fontSize: 12),
      ),
    ]);

    if (contact.role == 3) {
      details.add(
        const Text(
          'Catedratico',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }

    return details;
  }

  Future<void> _loadContacts() async {
    await authChatService.userChatContacts(true, environmentProvider.apiUrl);
    setState(() {
      _contacts = authChatService.contacts!;
      _numberOfContacts = _contacts.length;
    });

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
