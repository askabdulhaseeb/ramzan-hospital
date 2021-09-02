import 'package:cloud_firestore/cloud_firestore.dart';

class PatientInfo {
  PatientInfo({
    this.patient_id,
    this.name,
    this.age,
    this.phone,
    this.town,
    this.city,
    this.formattedAddress,
  });
  String? patient_id;
  String? name;
  String? age;
  String? phone;
  String? town;
  String? city;
  String? formattedAddress;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patient_id': patient_id ?? '',
      'name': name ?? '',
      'age': age ?? 0,
      'phone': phone ?? '',
      'town': town ?? '',
      'city': city ?? '',
      'formattedAddress': formattedAddress ?? '',
    };
  }

  // ignore: sort_constructors_first
  factory PatientInfo.fromDocument(DocumentSnapshot<Map<String, dynamic>> docs) {
    return PatientInfo(
      patient_id: docs.data()!['patient_id'].toString(),
      name: docs.data()!['name'].toString(),
      age: docs.data()!['age'].toString(),
      phone: docs.data()!['phone'].toString(),
      town: docs.data()!['town'].toString(),
      city: docs.data()!['city'].toString(),
      formattedAddress: docs.data()!['formattedAddress'].toString(),
    );
  }
}
