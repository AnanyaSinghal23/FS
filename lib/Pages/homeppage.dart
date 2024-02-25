import 'package:farm_samarth/export.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello ${currentUser?.displayName ?? ''}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Weather: Sunny', 
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data'));
                } else {
                  List<UserData> userDataList = snapshot.data as List<UserData>;
                  return ListView.builder(
                    itemCount: userDataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(userDataList[index].name),
                        subtitle: Text('Number: ${userDataList[index].number}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Logbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'News',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action when profile icon is clicked
          // Navigate to profile page or show a profile dialog
        },
        child: Icon(Icons.person),
      ),
    );
  }

  Future<List<UserData>> fetchUserData() async {
    // Replace this function with your logic to fetch data from Firebase
    // Example: Fetching data from a Firestore collection
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<UserData> userDataList = [];

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      String name = data['name'] ?? '';
      String number = data['number'] ?? '';
      userDataList.add(UserData(name: name, number: number));
    }

    return userDataList;
  }
}

class UserData {
  final String name;
  final String number;
  UserData({required this.name, required this.number});
}
