import 'package:flutter/material.dart';

void main() {
  var app = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(
          title: const Text('Let\'s see some images'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Hi there!');
          },
          child: const Icon(Icons.add),
        ),
      ),
  );

  runApp(app);

}
