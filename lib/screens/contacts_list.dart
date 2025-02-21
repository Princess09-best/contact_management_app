import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ContactsListScreen extends StatefulWidget {
  @override
  _ContactsListScreenState createState() => _ContactsListScreenState();
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

  // Fetch all contacts from the API
  Future<void> fetchContacts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      List<Map<String, dynamic>> data = await ApiService.getAllContacts();
      setState(() {
        contacts = data;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Failed to load contacts. Please try again.";
        isLoading = false;
      });
    }
  }

  // Delete a contact
  Future<void> deleteContact(int contactId) async {
    try {
      bool success = await ApiService.deleteContact(contactId);
      if (success) {
        fetchContacts(); // Refresh list after deletion
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to delete contact")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts List")),
      body: RefreshIndicator(
        onRefresh: fetchContacts,
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage)) // Show error message
                : ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Card(
                        child: ListTile(
                          title: Text(contact['pname'],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(contact['pphone']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/edit_contact',
                                    arguments:
                                        contact, // Pass contact data to edit screen
                                  ).then((_) =>
                                      fetchContacts()); // Refresh list after editing
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Delete Contact"),
                                      content: Text(
                                          "Are you sure you want to delete ${contact['pname']}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            deleteContact(contact['pid']);
                                          },
                                          child: Text("Delete",
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
