import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;

  ProfilePage({required this.userEmail});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late String userName;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchUserData();
  // }

  // Future<void> fetchUserData() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  //     setState(() {
  //       userName = userData['name'] ?? '';
  //     });
  //   }
  // }

  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("लॉगआउट करें?"),
          content: Text("क्या आप निश्चित हैं कि आप लॉगआउट करना चाहते हैं?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("नहीं"),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("हाँ"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('आपकी प्रोफाइल'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // You can add an image here if needed
            ),
            SizedBox(height: 20),
            Text('ईमेल: ${widget.userEmail}'),
            Text('नाम: ${widget.userEmail.substring(0, widget.userEmail.indexOf('@'))}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showLogoutDialog(),
              child: Text('लॉगआउट'),
            ),
          ],
        ),
      ),
    );
  }
}
