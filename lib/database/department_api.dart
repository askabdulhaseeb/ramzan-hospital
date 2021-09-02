import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/department.dart';
import '../utilities/custom_toast.dart';

class DepartmentAPI {
  static const String _colloection = 'departments';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<void> addDepartment(Department department) async {
    await _instance
        .collection(_colloection)
        .doc(department.depId)
        .set(department.toMap())
        .catchError((Object e) {
      CustomToast.errorToast(message: e.toString());
    });
  }
}
