import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'edit_contacts.dart';

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
      if (mounted) {
        setState(() {
          contacts = data;
          isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = "Failed to load contacts. Please try again.";
          isLoading = false;
        });
      }
    }
  }

  Future<void> deleteContact(int contactId) async {
    try {
      bool success = await ApiService.deleteContact(contactId);

      if (!mounted) return; // ✅ Ensure widget is still in the tree

      if (success) {
        fetchContacts();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Contact deleted successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete contact")),
        );
      }
    } catch (error) {
      if (!mounted) return; // ✅ Prevent using context if unmounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditContactScreen(contact: contact),
                                  ),
                                ).then((result) {
                                  if (result == true) {
                                    fetchContacts();
                                  } // ✅ Refresh contacts on return
                                });
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
                                        onPressed: () => Navigator.pop(context),
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
    );
  }
}
