import 'heading_title.dart';

class PDF {
  final PatientInfo info;
  final HeadingTitle headingTitle;
  // ignore: sort_constructors_first
  const PDF({
    required this.info,
    required this.headingTitle,
  });
}

class PatientInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  // ignore: sort_constructors_first
  const PatientInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}
