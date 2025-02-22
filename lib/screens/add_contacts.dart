import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  AddContactScreenState createState() => AddContactScreenState();
}

class AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = false;

  Future<void> _addContact() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      String result = await ApiService.addContact(
        _nameController.text.trim(),
        _phoneController.text.trim(),
      );

      if (!mounted) return;

      if (result.toLowerCase() == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Contact added successfully!")),
        );
        _formKey.currentState!.reset(); // ✅ Clear form after success
        _nameController.clear();
        _phoneController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add contact.")),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact")),
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
                      onPressed: _addContact,
                      child: Text("Add Contact"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
