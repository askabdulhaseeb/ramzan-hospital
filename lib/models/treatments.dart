import 'dart:convert';

class Treatment {
  Treatment({this.treatmentId, this.name, this.fee});
  String? treatmentId;
  String? name;
  double? fee;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'treatment_id': treatmentId,
      'name': name,
      'fee': fee,
    };
  }

  // ignore: sort_constructors_first
  factory Treatment.fromMap(Map<String, dynamic> map) {
    return Treatment(
      treatmentId: map['treatment_id'].toString(),
      name: map['name'].toString(),
      fee: double.parse(map['fee'].toString()),
    );
  }
}
