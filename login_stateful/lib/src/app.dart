import 'package:flutter/material.dart';
import 'package:login_stateful/src/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Log me In!',
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}