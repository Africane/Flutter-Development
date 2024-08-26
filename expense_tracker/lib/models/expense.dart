import 'package:isar/isar.dart';

// cmd :dart run build_runner build
// to generate isar file
part 'expense.g.dart';

class Expense {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final DateTime date;

  Expense({
    required this.name,
    required this.amount,
    required this.date,
  });
}