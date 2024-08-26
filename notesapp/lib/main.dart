import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    )
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required String title});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            
          },
          child: const Text('Register'),
        ),
      ),
    );
  }
}
