// THESE ARE USEFUL FUNCTIONS ACROSS THE APP

import 'package:intl/intl.dart';

// Convert string to a double
double convertStringToDouble(String string) {
  double? amount = double.tryParse(string);
  return amount ?? 0;
}

//format double amount into dollars and cents
String formatAmount(double amount) {
  final format = NumberFormat.currency(locale: "en_US", symbol: "\$", decimalDigits: 2);
  return format.format(amount);
}