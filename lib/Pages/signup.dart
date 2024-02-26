import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_samarth/export.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup Successful!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Wait for a short duration to show the loading image
        await Future.delayed(Duration(seconds: 1));

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(userEmail: emailController.text),
          ),
        );
      }
    } catch (e) {
      // Show error snackbar
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error: $e'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );

      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: signUp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display loading image while waiting for signup
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: Color(0xFFF0EDE8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          width: 59,
                          height: 61,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/image 9.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'यूजर पंजीकरण',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              height: 0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'ईमेल *',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'पासवर्ड  *',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    labelText: 'पहला नाम *',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    labelText: 'अंतिम नाम *',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: middleNameController,
                                  decoration: InputDecoration(
                                    labelText: 'मध्य नाम',
                                  ),
                                ),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: mobileNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'मोबाइल नंबर *',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your mobile number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 3),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color.fromARGB(
                                        255, 64, 112, 88), // Text color
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      signUp();
                                    }
                                  },
                                  child: Text('साइन अप करें'),
                                ),
                                SizedBox(height: 3),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue, // Text color
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text("पहले से ही एक खाता है? लॉगिन करें"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          height: 265,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/image 18.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/image 16.png", width: 100, height: 100),
                        SizedBox(height: 16.0),
                        Text(
                          'सफलतापूर्वक आपका खाता साइन इन हो गया है',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                color: Color(0xFFF0EDE8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: 59,
                      height: 61,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/image 9.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'यूजर पंजीकरण',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'ईमेल *',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 3),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'पासवर्ड  *',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 3),
                            TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                labelText: 'पहला नाम *',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 3),
                            TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                labelText: 'अंतिम नाम *',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 3),
                            TextFormField(
                              controller: middleNameController,
                              decoration: InputDecoration(
                                labelText: 'मध्य नाम',
                              ),
                            ),
                            SizedBox(height: 3),
                            TextFormField(
                              controller: mobileNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'मोबाइल नंबर *',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 3),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color.fromARGB(
                                    255, 64, 112, 88), // Text color
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signUp();
                                }
                              },
                              child: Text('साइन अप करें'),
                            ),
                            SizedBox(height: 3),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue, // Text color
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text("पहले से ही एक खाता है? लॉगिन करें"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      height: 265,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/image 18.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
