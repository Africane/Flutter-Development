import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});
    
    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers (to fetch expense data)
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // open new expense box
  void openNewExpenseBox() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
      title: Text("Add New Expense"),
      content: Column(
        // style the column
        mainAxisSize: MainAxisSize.min,

        children: [
          // user input for expense name
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),

          // user input for expense amount
          TextField(
            controller: amountController,
            decoration: const InputDecoration(hintText: "Amount"),
          ),
        ],
      ),
      // action buttons (cancel and save)
      actions: [
        // save button
        //_saveButton(),
        // cancel button
        _cancelButton(),
      ],

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

  // cancel button widget
  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () {
        // pop box
        Navigator.pop(context);

        // clear controllers
        nameController.clear();
        amountController.clear();
      },
      child: const Text('Cancel'),
    );
  }
}