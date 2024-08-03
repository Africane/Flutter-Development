import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Expense> _allExpenses = [];

  // Initialize db
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  // getter method
  List<Expense> get allExpense => _allExpenses;

  // OPERATIONS (CRUD)

  // Create - add a new expense
  Future<void> createNewExpense(Expense newExpense) async {
    // add to db
    await isar.writeTxn(() => isar.expenses.put(newExpense));
    // re-read from db
    await readExpenses();
  }

  // Read expenses from the db
  Future<void> readExpenses() async {
    // fetch all existing expenses from db
    List<Expense> fetchedExpenses = await isar.expenses.where().findAll();

    //give to local expense list
    _allExpenses.clear();
    _allExpenses.addAll(fetchedExpenses);

    // update UI
    notifyListeners();
  }

  // Update - edit an expense in db
  Future<void> updateExpense(int id, Expense updateExpense) async {
    // make sure new expense has same id as existing one
    updateExpense.id = id;

    // update in db
    await isar.writeTxn(() => isar.expenses.put(updateExpense));

    // re-read from db
    await readExpenses();

  }

  // Delete an expense
  Future<void> deleteExpense(int id) async {
    // delete from db
    await isar.writeTxn(() => isar.expenses.delete(id));

    // re-read from db
    await readExpenses();
  }

}