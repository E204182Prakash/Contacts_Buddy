import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue,Colors.purple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.account_box,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text('Contacts Buddy',style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 32,
            ),),
            Text("Version 1.0.0",style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 18,
            ),)
          ],
        ),
      ),
    );
  }
}
