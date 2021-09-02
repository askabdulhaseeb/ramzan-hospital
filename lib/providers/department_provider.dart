import 'package:flutter/material.dart';
import 'package:ramdazhospital/database/user_local_data.dart';
import 'package:ramdazhospital/models/department.dart';

class DepartmentProvider extends ChangeNotifier {
  final List<Department> _dep = <Department>[
    Department(
        depId: '111111', name: 'Eyes', createdBy: UserLocalData.getUserUID),
    Department(
        depId: '222222', name: 'Dentace', createdBy: UserLocalData.getUserUID),
  ];
  String? selectDep;
  List<Department> get department => <Department>[..._dep];
  void addDepartment(Department department) {
    _dep.add(department);
    notifyListeners();
  }

  void onChange(String? value) {
    selectDep = value;
    notifyListeners();
  }
}
