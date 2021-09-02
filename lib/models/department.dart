import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ramdazhospital/database/user_local_data.dart';

class Department {
  Department({
    this.depId,
    this.name,
    this.createdBy,
  });

  String? depId;
  String? name;
  String? createdBy;

  Map<String, dynamic> toMap() {
    return {
      'dep_id': depId,
      'name': name,
      'created_by': createdBy ?? UserLocalData.getUserUID,
    };
  }

  // ignore: sort_constructors_first
  factory Department.fromDocument(DocumentSnapshot<Map<String, dynamic>> docs) {
    return Department(
      depId: docs.data()!['dep_id'].toString(),
      name: docs.data()!['name'].toString(),
      createdBy: docs.data()!['created_by'].toString(),
    );
  }
}
