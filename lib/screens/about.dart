import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Management App",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Version: 1.0.0", style: TextStyle(fontSize: 16)),
            Divider(height: 20, thickness: 1),
            Text(
              "Developed by:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Princess Asiru-Balogun ( 88822025)",
                style: TextStyle(fontSize: 16)),
            Divider(height: 20, thickness: 1),
            Text(
              "About the App:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "This is a simple Contact Management App that allows users to add, edit, delete, and manage their contacts efficiently.",
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20, thickness: 1),
            Text(
              "Additional Information:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "• Built using Flutter & Dart\n• Uses an API for backend operations\n• Designed with Material UI",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
