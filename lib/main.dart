import 'package:flutter/material.dart';
import 'screens/contacts_list.dart'; // Contact List Page

import 'screens/add_contacts.dart'; // Add Contact Page
import 'screens/about.dart'; // About Page

void main() => runApp(const ContactManagementApp());

// Main Application
class ContactManagementApp extends StatelessWidget {
  const ContactManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.black,
          indicatorColor: const Color.fromARGB(255, 64, 6, 74),
        ),
      ),
      home: const NavigationExample(),
    );
  }
}

// Navigation with Bottom Navigation Bar
class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  NavigationExampleState createState() => NavigationExampleState();
}

class NavigationExampleState extends State<NavigationExample> {
  int _selectedIndex = 0;

  // List of screens for bottom navigation
  final List<Widget> _pages = [
    ContactsListScreen(), // Fetch and display contacts
    AddContactScreen(), // Add new contacts
    AboutScreen(), // About page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show the selected screen
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index; // Update selected page
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.contacts, color: Colors.white),
            icon: Icon(Icons.contacts_outlined, color: Colors.white),
            label: 'Contacts',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add, color: Colors.white),
            icon: Icon(Icons.add, color: Colors.white),
            label: 'Add Contact',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info, color: Colors.white),
            icon: Icon(Icons.info, color: Colors.white),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
