import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farm_samarth/export.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(userEmail: emailController.text),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_vortex.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w800,
                          ),
                          decoration: InputDecoration(
                            icon: Icon(Icons.mail),
                            labelText: 'Email *',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w800,
                          ),
                          decoration: InputDecoration(
                            icon: Icon(Icons.password),
                            labelText: 'Password *',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          child: Text('Log In'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text("Forgot Password?"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(), // Replace with your SignUpPage
                              ),
                            );
                          },
                          child: Text("Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


























// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   Future<void> login() async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       if (userCredential.user != null) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => HomePage(),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Opacity(
//             opacity: 0.4,
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/image_vortex.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'LOGIN',
//                     style: TextStyle(
//                       fontSize: 34,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: emailController,
//                           style: TextStyle(
//                             color: Colors.blue[900],
//                             fontWeight: FontWeight.w800,
//                           ),
//                           decoration: InputDecoration(
//                             icon: Icon(Icons.mail),
//                             labelText: 'Email *',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             String pattern =
//                                 r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
//                             RegExp regex = RegExp(pattern);
//                             if (!regex.hasMatch(value)) {
//                               return 'Enter a valid email';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFormField(
//                           controller: passwordController,
//                           style: TextStyle(
//                             color: Colors.blue[900],
//                             fontWeight: FontWeight.w800,
//                           ),
//                           decoration: InputDecoration(
//                             icon: Icon(Icons.password),
//                             labelText: 'Password *',
//                           ),
//                           obscureText: true,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             String pattern =
//                                 r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
//                             RegExp regex = RegExp(pattern);
//                             if (!regex.hasMatch(value)) {
//                               return "Weak Password\n\nMust contain:\n*Uppercase\n*Lowercase\n*Digit\n*Special Symbol !@#&*~\ ";
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 30),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               login();
//                             }
//                           },
//                           child: Text('Log In'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ForgotPassword(
//                                   title: 'Forgot Password',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text("Forgot Password?"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 50),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image(
//                                 image: AssetImage('assets/google.png'),
//                                 height: 45,
//                                 width: 45,
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('Sign Up With Google'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
