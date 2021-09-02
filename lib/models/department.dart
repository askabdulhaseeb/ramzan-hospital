import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/user_local_data.dart';

class Department {
  Department({
    this.depId,
    this.name,
    this.createdBy,
    this.status = true,
  });

  String? depId;
  String? name;
  String? createdBy;
  bool? status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dep_id': depId,
      'name': name,
      'created_by': createdBy ?? UserLocalData.getUserUID,
      'status': status,
    };
  }

  // ignore: sort_constructors_first
  factory Department.fromDocument(DocumentSnapshot<Map<String, dynamic>> docs) {
    return Department(
      depId: docs.data()!['dep_id'].toString(),
      name: docs.data()!['name'].toString(),
      createdBy: docs.data()!['created_by'].toString(),
      status: bool.fromEnvironment(docs.data()!['status'].toString()),
    );
  }
}
