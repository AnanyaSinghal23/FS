import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? currentUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}










// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'export.dart';

// void main() async{
//   //initialise flutter framework
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   User? currentUser=FirebaseAuth.instance.currentUser;
//   // if(currentUser != null) {
//     UserModel? thisUserModel = await FirebaseHelper.getUserModelById(
//         currentUser.uid);
//     // if (thisUserModel != null) {
//     //   runApp(
//     //       MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
//     // }
//     // else {
//       runApp(MyApp());
//   //   }
//   // }
//   // else{
//   //   runApp(MyApp());
//   // }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FirstPage(),
//     );
//   }
// }