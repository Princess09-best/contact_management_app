import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://apps.ashesi.edu.gh/contactmgt/actions/";

  // Fetch all contacts
  static Future<List<Map<String, dynamic>>> getAllContacts() async {
    final response = await http.get(Uri.parse("${baseUrl}get_all_contact_mob"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception("Failed to load contacts");
    }
  }

  // Fetch a single contact by ID
  static Future<Map<String, dynamic>> getContact(int contactId) async {
    final response = await http
        .get(Uri.parse("${baseUrl}get_a_contact_mob?contid=$contactId"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch contact");
    }
  }

  // ✅ Add a new contact using FormData
  static Future<String> addContact(String name, String phone) async {
    final response = await http.post(
      Uri.parse("${baseUrl}add_contact_mob"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // FormData Header
      },
      body: {
        "ufullname": name, // ✅ Sending key-value pairs
        "uphonename": phone,
      },
    );

    if (response.statusCode == 200) {
      return response.body.trim(); // Expected: "success" or "failed"
    } else {
      throw Exception("Failed to add contact");
    }
  }

  // ✅ Edit an existing contact using FormData
  static Future<String> editContact(
      int contactId, String name, String phone) async {
    final response = await http.post(
      Uri.parse("${baseUrl}update_contact"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "cname": name, // ✅ Form field name from API
        "cnum": phone,
        "cid": contactId.toString(),
      },
    );

    if (response.statusCode == 200) {
      return response.body.trim(); // Expected: "success" or "failed"
    } else {
      throw Exception("Failed to edit contact");
    }
  }

  // ✅ Delete a contact using FormData
  static Future<bool> deleteContact(int contactId) async {
    final response = await http.post(
      Uri.parse("${baseUrl}delete_contact"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "cid": contactId.toString(),
      },
    );

    if (response.statusCode == 200) {
      return response.body.trim().toLowerCase() == "true";
    } else {
      throw Exception("Failed to delete contact");
    }
  }
}
