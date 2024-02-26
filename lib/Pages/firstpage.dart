import 'dart:async';
import 'package:flutter/material.dart';
import 'package:farm_samarth/export.dart';

class FirstPage extends StatefulWidget {
  const FirstPage ({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Hi, this is a splash screen!'),
      ),
    );
  }
}
