import 'package:flutter/material.dart';
import 'package:http/http.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;

  void fetchImage() {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(
          title: const Text('Let\'s see some images'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: const Icon(Icons.add),
        ),
        body: Text('$counter'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}