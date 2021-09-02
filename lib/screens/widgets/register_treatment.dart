import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../database/treatment_api.dart';
import '../../models/treatments.dart';
import '../../utilities/custom_validator.dart';
import 'custom_textformfield.dart';

Future<dynamic> registerTreatment(BuildContext context) {
  final TextEditingController _temp = TextEditingController();
  final TextEditingController _fee = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomTextFormField(
              title: 'Treatment Name',
              controller: _temp,
              validator: (String? value) => CustomValidator.lessThen2(value),
            ),
            CustomTextFormField(
              title: 'Treatment Fee',
              controller: _fee,
              keyboardType: TextInputType.number,
              validator: (String? value) => CustomValidator.isEmpty(value),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Back'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_key.currentState!.validate()) {
              final Treatment treatment = Treatment(
                treatmentId: const Uuid().v1(),
                name: _temp.text.trim(),
                fee: double.parse(_fee.text),
              );
              await TreatmentAPI().addTreatment(treatment);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
