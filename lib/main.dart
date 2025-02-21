import 'package:flutter/material.dart';

void main() => runApp(const ContactManagementApp());

//contact management app
class ContactManagementApp extends StatelessWidget {
  const ContactManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp with Material3 theme
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, // Primary color
          brightness: Brightness.dark, // Use Brightness.light for light mode
        ),
        // Navigation Bar theme
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.black, // Navigation Bar background color
          indicatorColor: const Color.fromARGB(
              255, 64, 6, 74), // Selected item highlight color
        ),
      ),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatelessWidget {
  const NavigationExample({super.key});

  // Function to handle navigation with MaterialPageRoute
  void _navigateToPage(BuildContext context, int index) {
    Widget page;
    if (index == 0) {
      page = const ContactsPage();
    } else if (index == 1) {
      page = const AddContactPage();
    } else {
      page = const AboutPage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _navigateToPage(context, index);
        },
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.contacts, color: Colors.white),
            icon: const Icon(Icons.contacts_outlined, color: Colors.white),
            label: 'Contacts',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.add, color: Colors.white),
            icon: const Icon(Icons.add, color: Colors.white),
            label: 'Add Contact',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.info, color: Colors.white),
            icon: const Icon(Icons.info, color: Colors.white),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

//pages

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts ")),
      body: const Center(child: Text(" Contacts Page")),
    );
  }
}

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Contact")),
      body: const Center(child: Text(" Add Contact Page")),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: const Center(child: Text(" About Page")),
    );
  }
}
