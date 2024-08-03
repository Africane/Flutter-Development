import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  
  // open new expense box
  void openNewExpenseBox() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("New Expense"),
        content: Column(
          children: [
            // user input for expense name
            TextField(
              controller: nameController,
            ),

            // user input for expense amount
            TextField(
              controller: nameController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openNewExpenseBox,
        child: const Icon(Icons.add),
      ),
    );
  }
}