import '../model/headingTitle.dart';

class PDF {
  final InvoiceInfo info;
  final HeadingTitle headingTitle;
  // final List<InvoiceItem> items;

  const PDF({
    required this.info,
    required this.headingTitle,
    // required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

// class InvoiceItem {
//   final String description;
//   final DateTime date;
//   final int quantity;
//   final double vat;
//   final double unitPrice;

//   const InvoiceItem({
//     required this.description,
//     required this.date,
//     required this.quantity,
//     required this.vat,
//     required this.unitPrice,
//   });
// }
