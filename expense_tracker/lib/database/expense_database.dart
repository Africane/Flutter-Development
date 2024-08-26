import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Expense> _allExpenses = [];

  // T H E  S E T U P

  // Initialize the db
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  // G E T T E R S
  List<Expense> get allExpense => _allExpenses;

  // C R U D  O P E R A T I O N S

  // CREATE a new expense
  Future<void> createNewExpense(Expense newExpense) async {
    // add expense to db
    await isar.writeTxn(() => isar.expenses.put(newExpense));

    // re-read expense from the db
    await readExpenses();
  }

  // Read - expenses from db
  Future<void> readExpenses() async {
    // fetch all existing expenses from the db
    List<Expense> fetchedExpenses = await isar.expenses.where().findAll();

    // serve to local expense list after fetch
    _allExpenses.clear();
    _allExpenses.addAll(fetchedExpenses);

    // update the UI
    notifyListeners();
  }

  // UPDATE an existing expense
  Future<void> updateExpense(int id, Expense updatedExpense) async {
    // Ensure updated expense has same id as existing one
    updatedExpense.id = id;

    // update the new expense in the db
    await isar.writeTxn(() => isar.expenses.put(updatedExpense));

    // re-read from the db
    await readExpenses();
  }

  // DELETE an expense
  Future<void> deleteExpense(int id) async {
    // delete from db
    await isar.writeTxn(() => isar.expenses.delete(id));

    // re-read from db
    await readExpenses();
  }

  // H E L P E R   F U N C T I O N S

  // calculate total expenses for each month
  Future<Map<int, double>> calculateMonthlyTotals() async {
    // ensure the expenses are read from the db
    await readExpenses();

    // create a map to keep track of total expenses per month
    Map<int, double> monthlyTotals = {};

    // iterate over all expenses
    for (var expense in _allExpenses) {
      // extract the month from the date of the expense
      int month = expense.date.month;

      // if the month is not yet in the map, initialize to 0
      if (!monthlyTotals.containsKey(month)) {
        monthlyTotals[month] = 0;
      }

      // add the expense amount to the total for the month
      monthlyTotals[month] = monthlyTotals[month]! + expense.amount;
    }

    return monthlyTotals;
  }

  // get start month
  int getStartMonth() {
    if (_allExpenses.isEmpty) {
      return DateTime.now().month; // default to current month if no expenses are recorded
    }

    // sort expenses by date to find the earliest
    _allExpenses.sort(
      (a, b) => a.date.compareTo(b.date),
    );

    return _allExpenses.first.date.month;
  }

  // get start year
  int getStartYear() {
    if (_allExpenses.isEmpty) {
      return DateTime.now().year; // default to current month if no expenses are recorded
    }

    // sort expenses by date to find the earliest
    _allExpenses.sort(
      (a, b) => a.date.compareTo(b.date),
    );

    return _allExpenses.first.date.year;
  }
}