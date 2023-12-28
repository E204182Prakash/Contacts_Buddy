import 'package:flutter/material.dart';
import '../model/contact_model.dart';
import '../view_model/contact_view_model.dart';
import 'home_screen.dart';

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;

  const UpdateContactScreen({Key? key, required this.contact}) : super(key: key);

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  late ContactViewModel _contactViewModel;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contactViewModel = ContactViewModel();

    nameTextController.text = widget.contact.name;
    phoneNumberTextController.text = widget.contact.phoneNumber.toString();
    emailTextController.text = widget.contact.email;
  }

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    phoneNumberTextController.dispose();
    emailTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameTextController,
              decoration: const InputDecoration(
                labelText: 'Name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: phoneNumberTextController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: emailTextController,
              decoration: const InputDecoration(
                labelText: 'Email',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 100.0,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () async {
                  // Update the contact with new values
                  Contact updatedContact = Contact(
                    id: widget.contact.id,
                    name: nameTextController.text,
                    phoneNumber: int.parse(phoneNumberTextController.text),
                    email: emailTextController.text,
                  );
                  await _contactViewModel.updateContact(updatedContact);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contact updated successfully'),
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: const Text(
                  'UPDATE',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

