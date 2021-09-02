import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../database/patient_info_api.dart';
import '../../models/patient_info.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../home_screen/home_screen.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/show_loading.dart';

class RegisterPatientScreen extends StatefulWidget {
  const RegisterPatientScreen({Key? key}) : super(key: key);
  static const String routeName = '/RegisterPatientScreen';
  @override
  _RegisterPatientScreenState createState() => _RegisterPatientScreenState();
}

class _RegisterPatientScreenState extends State<RegisterPatientScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _town = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _formattedAddress = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Patient'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              CustomTextFormField(
                title: 'Name',
                controller: _name,
                validator: (String? value) => CustomValidator.lessThen3(value),
              ),
              CustomTextFormField(
                title: 'Age',
                controller: _age,
                keyboardType: TextInputType.number,
                validator: (String? value) => CustomValidator.isEmpty(value),
              ),
              CustomTextFormField(
                title: 'Phone Number',
                controller: _phoneNumber,
                keyboardType: TextInputType.number,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              CustomTextFormField(
                title: 'Town Name',
                controller: _town,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              CustomTextFormField(
                title: 'City',
                controller: _city,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              CustomTextFormField(
                title: 'Complete Formatted Address',
                controller: _formattedAddress,
                textInputAction: TextInputAction.done,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              ElevatedButton(
                onPressed: () async {
                  showLoadingDislog(context);
                  if (_key.currentState!.validate()) {
                    final PatientInfo patient = PatientInfo(
                      patientId: const Uuid().v1(),
                      name: _name.text.trim(),
                      age: _age.text.trim(),
                      phone: _phoneNumber.text.trim(),
                      town: _town.text.trim(),
                      city: _city.text.trim(),
                      formattedAddress: _formattedAddress.text.trim(),
                    );
                    PatientInfoAPI().addPatient(patient);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed(
                      HomeScreen.routeName,
                    );
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
