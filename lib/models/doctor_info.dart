import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/user_local_data.dart';

class DoctorInfo {
  DoctorInfo({
    this.doctorID,
    this.name,
    this.fee,
    this.depID,
    this.addedBy,
    this.status = true,
  });
  String? doctorID;
  String? name;
  double? fee;
  String? depID;
  String? addedBy;
  bool? status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctor_id': doctorID,
      'name': name,
      'fee': fee,
      'dep_id': depID,
      'added_by': UserLocalData.getUserUID,
      'status': status,
    };
  }

  // ignore: sort_constructors_first
  factory DoctorInfo.fromMap(DocumentSnapshot<Map<String, dynamic>> docs) {
    return DoctorInfo(
      doctorID: docs.data()!['doctor_id'].toString(),
      name: docs.data()!['name'].toString(),
      fee: double.parse(docs.data()!['fee'].toString()),
      depID: docs.data()!['dep_id'].toString(),
      addedBy: docs.data()!['added_by'].toString(),
      status: bool.fromEnvironment(docs.data()!['status'].toString()),
    );
  }
}
