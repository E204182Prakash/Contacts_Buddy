import 'package:flutter/material.dart';
import 'package:test_contact_app/view/home_screen.dart';
import 'package:test_contact_app/view_model/contact_view_model.dart';
import '../model/contact_model.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late ContactViewModel _contactViewModel;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contactViewModel = ContactViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    phoneNumberTextController.dispose();
    emailTextController.dispose();
  }

  // Phone number Validation function
  bool validatePhoneNumber(String phoneNumber) {
    return phoneNumber.length == 10 && int.tryParse(phoneNumber) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Contact"),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: nameTextController,
            decoration: const InputDecoration(
              labelText: 'Name',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: phoneNumberTextController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: emailTextController,
            decoration: const InputDecoration(
              labelText: 'Email',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 100.0,
            height: 60.0,
            child: ElevatedButton(
              onPressed: () async {
                if (nameTextController.text.isEmpty ||
                    phoneNumberTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter Name and Phone Number.'),
                    ),
                  );
                }
                else {
                  String phoneNumber = phoneNumberTextController.text;
                  if(validatePhoneNumber(phoneNumber)){
                    Contact newContact = Contact(
                        name: nameTextController.text,
                        phoneNumber: int.parse(phoneNumberTextController.text),
                        email: emailTextController.text
                    );
                    await _contactViewModel.insertContact(newContact);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contact saved successfully'),
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid phone number'),
                        ),
                    );
                  }

                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              child: const Text(
                "SAVE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
