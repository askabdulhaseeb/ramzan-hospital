import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../database/department_api.dart';
import '../../models/department.dart';
import '../../providers/department_provider.dart';
import '../../utilities/custom_validator.dart';
import 'custom_textformfield.dart';

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
                final Department department = Department(
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
