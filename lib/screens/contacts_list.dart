import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  List<Map<String, dynamic>> contacts = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      List<Map<String, dynamic>> data = await ApiService.getAllContacts();
      print("Fetched Contacts: $data"); // Debugging

      setState(() {
        contacts = data;
        isLoading = false;
      });
    } catch (error) {
      print("Error Fetching Contacts: $error"); // Debugging
      setState(() {
        errorMessage = "Failed to load contacts. Please try again.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts List")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      title: Text(contact['pname']),
                      subtitle: Text(contact['pphone']),
                    );
                  },
                ),
    );
  }
}
