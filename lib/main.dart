import 'package:flutter/material.dart';
import 'package:test_contact_app/view/home_screen.dart';
import 'package:test_contact_app/view/splash_screen.dart';
import 'package:test_contact_app/view_model/contact_view_model.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return ContactViewModel();
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts Buddy',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.grey[100]),
      ),
      home: FutureBuilder(
        // setting the delay
        future: Future.delayed(Duration(seconds: 4)),
        builder: (context, snapshot) {
          // Check if the delay is complete
          if (snapshot.connectionState == ConnectionState.done) {
            return HomeScreen();
          } else {
            // Otherwise, display the splash screen
            return SplashScreen();
          }
        },
      ),
    );
  }
}
