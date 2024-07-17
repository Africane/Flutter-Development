import 'package:flutter/material.dart';

// create a class that will be our custom widget
// this class must extend the 'StatelessWidget' base class
class MyApp extends StatelessWidget {
  Widget build(context) {
     return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s See some Images'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.clear),
        onPressed: () {
        print('Hi there!');
      },),
    ),
    debugShowCheckedModeBanner: false,
  );
  }
}

// must define a 'build' method that returns the widgets that *this* 
//widget will show