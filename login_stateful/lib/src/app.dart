import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Log Me In',
      home: Scaffold(
        body: Center(
          child: Text('Show a form here!')),
      ),
    );
  }
}