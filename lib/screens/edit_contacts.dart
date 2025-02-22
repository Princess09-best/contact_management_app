import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditContactScreen extends StatefulWidget {
  final Map<String, dynamic> contact; // Pass existing contact data

  const EditContactScreen({super.key, required this.contact});

  @override
  EditContactScreenState createState() => EditContactScreenState();
}

class EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>(); // Form validation key
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact['pname']);
    _phoneController = TextEditingController(text: widget.contact['pphone']);
  }

  Future<void> _updateContact() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      String result = await ApiService.editContact(
        widget.contact['pid'], // Pass contact ID
        _nameController.text.trim(),
        _phoneController.text.trim(),
      );

      if (!mounted) return; //  Ensure widget is still in the tree

      if (result.toLowerCase() == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Contact updated successfully!")),
        );
        Navigator.pop(context, true); //  Return true to refresh contacts list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update contact.")),
        );
      }
    } catch (error) {
      if (!mounted) return; // Prevent using context if unmounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }

    if (mounted) setState(() => isLoading = false); //  Safe state update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Full Name"),
                validator: (value) =>
                    value!.isEmpty ? "Name cannot be empty" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? "Phone number cannot be empty" : null,
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _updateContact,
                      child: Text("Update Contact"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
