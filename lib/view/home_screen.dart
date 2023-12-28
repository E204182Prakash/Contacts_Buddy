import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_contact_app/model/contact_model.dart';
import 'package:test_contact_app/view/add_contact_screen.dart';
import 'package:test_contact_app/view/update_contact_screen.dart';
import 'package:test_contact_app/view_model/contact_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ContactViewModel _contactViewModel;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contactViewModel = ContactViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search contacts...',
          ),
          onSubmitted: (value) {
            _contactViewModel.searchContacts(value);
            setState(() {});
          },
        ),
      ),
      body: Consumer<ContactViewModel>(
        builder: (context, contactViewModel, child) {
          return FutureBuilder(
            future: contactViewModel.retrieveContacts(),
            builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              if (snapshot.hasData) {
                // the searchController.text to filter contacts and show the results
                List<Contact> displayedContacts = _contactViewModel.filterContacts(snapshot.data, searchController.text);
                return ListView.builder(
                  itemCount: displayedContacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    var w;
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(05), // Add rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(05.0),
                        child: SizedBox(
                          width: w,
                          height: 90.0,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                        "Name : ${displayedContacts[index].name}       ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                          ),
                                    Text(
                                        "Phone Number : ${displayedContacts[index].phoneNumber.toString()}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("Email : ${displayedContacts[index].email}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _contactViewModel.deleteContact(displayedContacts[index].id!);
                                              setState(() {
                                                displayedContacts.remove(displayedContacts[index]);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Contact is Deleted'),
                                                  ),
                                                );
                                              });
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => UpdateContactScreen(
                                                    contact: displayedContacts[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                            IconButton(
                                              onPressed: () {
                                                _contactViewModel.launchPhoneCall(displayedContacts[index].phoneNumber.toString());
                                              },
                                              icon: const Icon(Icons.phone),
                                            ),
                                            IconButton(
                                                onPressed: (){
                                                  _contactViewModel.shareDirectMessageFromWhatsApp(displayedContacts[index]);
                                                },
                                                icon: const Icon(Icons.chat),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.account_circle_sharp),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddUserScreen()),
          );
        },
      ),
    );
  }
}