import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/helper/helper_functions.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});
    
    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers (to fetch expense data)
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        _createNewExpenseButton(),

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

  // save button widget
  Widget _createNewExpenseButton() {
    return MaterialButton(
      onPressed:  () async {
      // only save if there is sth in the text field to save
      if (
        nameController.text.isNotEmpty && 
        amountController.text.isNotEmpty) {
          // pop box
          Navigator.pop(context);

          // create new expense
          Expense newExpense = Expense(
            name: nameController.text,
            amount: convertStringToDouble(amountController.text),
            date: DateTime.now(),
          );

          // save to db
          await context.read<ExpenseDatabase>().createNewExpense(newExpense);

          // clear the controllers
          nameController.clear();
          amountController.clear();
      }
    },
    child: Text('Save'),
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