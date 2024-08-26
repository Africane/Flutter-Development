import 'package:expense_tracker/components/my_list_tile.dart';
import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/helper/helper_functions.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
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
    Provider.of<ExpenseDatabase>(context, listen: false).readExpenses();
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

  // open edit box
  void openEditBox(Expense expense) {
    // pre-fill existing values into text fields
    String existingName = expense.name;
    String existingAmount = expense.amount.toString();

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
      title: const Text("Edit Expense"),
      content: Column(
        // style the column
        mainAxisSize: MainAxisSize.min,

        children: [
          // user input for expense name
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: existingName),
          ),

          // user input for expense amount
          TextField(
            controller: amountController,
            decoration: InputDecoration(hintText: existingAmount),
          ),
        ],
      ),
      // action buttons (cancel and save)
      actions: [
        // edit button
        _editExpenseButton(expense),

        // cancel button
        _cancelButton(),
      ],

    ),
  );
  }

  // open delete box
  void openDeleteBox(Expense expense) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
      title: Text("Delete Expense?"),
      
      // action buttons (cancel and save)
      actions: [
        // delete button
        _deleteExpenseButton(expense.id),

        // cancel button
        _cancelButton(),
      ],

    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>
    (builder: (context, value, child) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openNewExpenseBox,
        child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.allExpense.length,
          itemBuilder: (context, index) {

          // get individual expense
          Expense individualExpense = value.allExpense[index];

          // return list tile UI
          return MyListTile(
            title: individualExpense.name, 
            trailing: formatAmount(individualExpense.amount),
            onEditPressed: (context) => openEditBox(individualExpense),
            onDeletePressed: (context) => openDeleteBox(individualExpense),
        );
        },
        ),
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

  // save button - edit existing expense
  Widget _editExpenseButton(Expense expense) {
    return MaterialButton(
      onPressed: () async {
        // save as long as at least one textfield has been changed
        if (
          nameController.text.isNotEmpty || 
          amountController.text.isNotEmpty) {
            // pop box
            Navigator.pop(context);

            // create a new updated expense
            Expense updatedExpense = Expense(
              name: nameController.text.isNotEmpty
                ? nameController.text
                : expense.name,
              amount: amountController.text.isNotEmpty 
                ? convertStringToDouble(amountController.text)
                : expense.amount,
              date: DateTime.now(), 
            );

            // old expense id
            int existingId = expense.id;

            // save to db
            await context
              .read<ExpenseDatabase>()
              .updateExpense(existingId, updatedExpense);
          }
      },
      child: const Text('Save'),
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

  // delete button on the edit
  Widget _deleteExpenseButton(int id) {
    return MaterialButton(
      onPressed: () async {
        // pop box
        Navigator.pop(context);

        // delete expense from db
        await context.read<ExpenseDatabase>().deleteExpense(id);
    },
    child: const Text('Delete'),
    );
  }
}