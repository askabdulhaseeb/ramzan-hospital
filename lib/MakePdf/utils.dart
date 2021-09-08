import 'package:intl/intl.dart';

class Utils {
  static String formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static String formatDate(DateTime date) => DateFormat.yMd().format(date);
}
