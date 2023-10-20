import 'package:flutter/material.dart';
import 'package:gam/chat/models/contact_chat.dart';
import 'package:gam/chat/pages/pages.dart';
import 'package:gam/chat/services/chat_service.dart';
import 'package:provider/provider.dart';

class ContactSearchDelegate extends SearchDelegate<ContactChat?> {
  ContactSearchDelegate({ required List<ContactChat> contacts })
    : _contacts = contacts;

  @override
  String? get searchFieldLabel => 'Buscar nombre';
  final List<ContactChat> _contacts;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if( query.trim().isEmpty ) {
      query = '';
      return Container();
    }

    List<ContactChat> resultingList = _searchContactByName(query.toLowerCase());

    if( resultingList.isEmpty ) {
      return Container(
        alignment: Alignment.center,
        height: 64.0,
        child: Text('No se encontro "$query"'),
      );
    }

    query = '';
    return _showContacts(context, resultingList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if( query.trim().isEmpty ) {
      return Container();
    }

    List<ContactChat> resultingList = _searchContactByName(query.toLowerCase());

    if( resultingList.isEmpty ) {
      return Container(
        alignment: Alignment.center,
        height: 64.0,
        child: Text('No se encontro "$query"'),
      );
    }

    return _showContacts(context, resultingList);
  }

  List<ContactChat> _searchContactByName(String name) {
    return _contacts
      .where((contact) => '${contact.firstName} ${contact.lastName}'
      .toLowerCase()
      .contains(name))
      .toList();
  }

  Widget _showContacts(BuildContext context, List<ContactChat> contacts) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (_, i) {
        final contact = contacts[i];

        return ListTile(
          contentPadding: const EdgeInsets.only(left: 8.0, top: 8.0),
          leading: CircleAvatar(
            backgroundColor: Colors.grey[400],
            child: const Icon(Icons.person, color: Colors.white),
          ),
          title: Text("${contact.firstName} ${contact.lastName}"), 
          onTap: () {
            final chatService = Provider.of<ChatService>(context, listen: false);
            chatService.contactFor = contact;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ChatPage(
                  title: contact.firstName,
                  chatType: 'single',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
