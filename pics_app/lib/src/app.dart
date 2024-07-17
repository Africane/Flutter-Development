import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:pics_app/src/models/image_model.dart';
import 'dart:convert';
import 'package:pics_app/src/models/widgets/image_list.dart';

class MyApp extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<MyApp> {
  int counter = 0;

  List<ImageModel> images = [];

  void fetchImage() async {
    counter ++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$counter' as Uri);
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    
    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(context) {
     return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s See some Images'),
      ),
      body: ImageList(images),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: fetchImage,
      ),
    ),
    debugShowCheckedModeBanner: false,
  );
  }
}