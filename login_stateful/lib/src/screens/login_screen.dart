import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              emailField(),
              passwordField(),
              Container(margin: const EdgeInsets.only(top: 25.0)),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
    );
  }
  
  Widget passwordField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Password',
        ),
      );
  }

  Widget submitButton() {
    return const ElevatedButton(
      onPressed: () {},
      child: Text('Submit'),
    );
  }
  
}