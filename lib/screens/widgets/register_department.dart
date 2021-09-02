import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramdazhospital/database/department_api.dart';
import 'package:ramdazhospital/models/department.dart';
import 'package:ramdazhospital/providers/department_provider.dart';
import 'package:ramdazhospital/screens/widgets/custom_textformfield.dart';
import 'package:ramdazhospital/utilities/custom_validator.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> registerDepartment(BuildContext context) {
  final TextEditingController _dep = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back'),
        ),
        Consumer<DepartmentProvider>(
          builder: (
            BuildContext context,
            DepartmentProvider dep,
            Widget? child,
          ) =>
              ElevatedButton(
            onPressed: () async {
              if (_dep.text.length > 1) {
                Department department = Department(
                  depId: const Uuid().v1(),
                  name: _dep.text.trim(),
                );
                DepartmentAPI().addDepartment(department);
                dep.addDepartment(department);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextFormField(
            title: 'Department',
            controller: _dep,
            validator: (String? value) => CustomValidator.lessThen2(value),
          ),
        ],
      ),
    ),
  );
}
