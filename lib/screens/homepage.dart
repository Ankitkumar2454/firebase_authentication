import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 6, 230),
        appBar: AppBar(
          title: Center(
            child: Text(
              "DASHBOARD SCREEN",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'USER DETAILS',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                user.toString(),
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.close),
                label: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
