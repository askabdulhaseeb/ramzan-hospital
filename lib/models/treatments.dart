import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Treatment {
  Treatment({this.treatmentId, this.name, this.fee, this.status = true});
  String? treatmentId;
  String? name;
  double? fee;
  bool? status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'treatment_id': treatmentId,
      'name': name,
      'fee': fee,
      'status': status
    };
  }

  // ignore: sort_constructors_first
  factory Treatment.fromMap(DocumentSnapshot<Map<String, dynamic>> docs) {
    return Treatment(
      treatmentId: docs.data()!['treatment_id'].toString(),
      name: docs.data()!['name'].toString(),
      fee: double.parse(docs.data()!['fee'].toString()),
      status: bool.fromEnvironment(docs.data()!['status'].toString()),
    );
  }
}
