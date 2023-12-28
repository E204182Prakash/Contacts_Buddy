import 'package:flutter/cupertino.dart';
import 'package:test_contact_app/model/contact_model.dart';
import 'package:test_contact_app/model/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactViewModel extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  ContactViewModel() {
    _databaseHelper = DatabaseHelper();
  }

  //Send Message through whatsapp directly to the saved contact
  Future<void> shareDirectMessageFromWhatsApp(Contact contact) async {
    final String phoneNumber = contact.phoneNumber.toString();

    String message = 'Hi!,How you doing?';

    final String whatsappUrl = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
    await launch(whatsappUrl);
  }

  // Function to launch a phone call
  Future<void> launchPhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
      await launchUrl(uri);
    }

  //Search contact function
  List<Contact> filterContacts(List<Contact>? contacts, String searchTerm) {
    if (contacts == null || contacts.isEmpty) {
      return [];
    }
    return contacts.where((contact) {
      return contact.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
          contact.email.toLowerCase().contains(searchTerm.toLowerCase()) ||
          contact.phoneNumber.toString().contains(searchTerm);
    }).toList();
  }

  void searchContacts(String searchTerm) {
    notifyListeners();
  }

  Future<List<Contact>> retrieveContacts() async {
    notifyListeners();
    return _databaseHelper.retrieveContact();
  }

  Future<int> insertContact(Contact contact) async {
    notifyListeners();
    return _databaseHelper.insertContact([contact]);
  }

  Future<void> deleteContact(int id) async {
    notifyListeners();
    await _databaseHelper.deleteContact(id);
  }

  Future<int> updateContact(Contact contact) async {
    notifyListeners();
    return _databaseHelper.updateContact([contact]);
  }

}

