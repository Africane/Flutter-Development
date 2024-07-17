import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<MyApp> {
  int counter = 0;

  Widget build(context) {
     return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s See some Images'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
      ),
    ),
    debugShowCheckedModeBanner: false,
  );
  }
}

// must define a 'build' method that returns the widgets that *this* 
//widget will show