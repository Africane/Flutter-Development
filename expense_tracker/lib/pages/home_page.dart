import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/components/my_list_tile.dart';
import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/helper/helper_functions.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
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

  // futures to load graph data
  Future<Map<int, double>>? _monthlyTotalsFuture;

  @override
  void initState() {
    // read db on initial startup
    Provider.of<ExpenseDatabase>(context, listen: false).readExpenses();

    // load futures
    refreshGraphData();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  // refresh graph data
  void refreshGraphData() {
    _monthlyTotalsFuture = Provider.of<ExpenseDatabase>(context, listen: false).calculateMonthlyTotals();
  }

  // open new expense box
  void openNewExpenseBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Expense"),
        content: Column(
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
        actions: [
          _createNewExpenseButton(),
          _cancelButton(),
        ],
      ),
    );
  }

  // open edit box
  void openEditBox(Expense expense) {
    String existingName = expense.name;
    String existingAmount = expense.amount.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: existingName),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(hintText: existingAmount),
            ),
          ],
        ),
        actions: [
          _editExpenseButton(expense),
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
        actions: [
          _deleteExpenseButton(expense.id),
          _cancelButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(builder: (context, value, child) {
      int startMonth = value.getStartMonth();
      int getStartYear = value.getStartYear();
      int currentMonth = DateTime.now().month;
      int currentYear = DateTime.now().year;

      int monthCount = calculateMonthCount(
        getStartYear,
        startMonth,
        currentYear,
        currentMonth,
      );

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: openNewExpenseBox,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: FutureBuilder<Map<int, double>>(
                  future: _monthlyTotalsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final monthlyTotals = snapshot.data ?? {};
                      List<double> monthlySummary = List.generate(monthCount,
                          (index) => monthlyTotals[startMonth + index] ?? 0.0);
                      return MyBarGraph(
                        monthlySummary: monthlySummary,
                        startMonth: startMonth,
                      );
                    } else {
                      return const Center(
                        child: Text('Loading...'),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: value.allExpense.length,
                  itemBuilder: (context, index) {
                    Expense individualExpense = value.allExpense[index];
                    return MyListTile(
                      title: individualExpense.name,
                      trailing: formatAmount(individualExpense.amount),
                      onEditPressed: (context) => openEditBox(individualExpense),
                      onDeletePressed: (context) => openDeleteBox(individualExpense),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // save button widget - create new expense
  Widget _createNewExpenseButton() {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty &&
            amountController.text.isNotEmpty) {
          Navigator.pop(context);
          Expense newExpense = Expense(
            name: nameController.text,
            amount: convertStringToDouble(amountController.text),
            date: DateTime.now(),
          );

          // save to db
          await context.read<ExpenseDatabase>().createNewExpense(newExpense);

          // refresh graph
          refreshGraphData();
          
          // clear controllers
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
        if (nameController.text.isNotEmpty ||
            amountController.text.isNotEmpty) {
          Navigator.pop(context);
          Expense updatedExpense = Expense(
            name: nameController.text.isNotEmpty
                ? nameController.text
                : expense.name,
            amount: amountController.text.isNotEmpty
                ? convertStringToDouble(amountController.text)
                : expense.amount,
            date: DateTime.now(),
          );
          int existingId = expense.id;
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
        Navigator.pop(context);
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
        Navigator.pop(context);
        await context.read<ExpenseDatabase>().deleteExpense(id);
      },
      child: const Text('Delete'),
    );
  }
}
