import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../database/doctor_indo_api.dart';
import '../../models/department.dart';
import '../../models/doctor_info.dart';
import '../../providers/department_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../home_screen/home_screen.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_inkwell_button.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/register_department.dart';

class RegisterDoctorScreen extends StatefulWidget {
  const RegisterDoctorScreen({Key? key}) : super(key: key);
  static const String routeName = '/RegisterDoctorScreen';
  @override
  _RegisterDoctorScreenState createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _edu = TextEditingController();
  final TextEditingController _fee = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final DepartmentProvider dep = Provider.of<DepartmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Doctor'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              CustomTextFormField(
                title: 'Name',
                controller: _name,
                hint: 'Doctor Name',
                validator: (String? value) => CustomValidator.lessThen3(value),
              ),
              CustomTextFormField(
                title: 'Education',
                controller: _edu,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              CustomTextFormField(
                title: 'Fee',
                controller: _fee,
                keyboardType: TextInputType.number,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              CustomDropdownButton(
                items: dep.department
                    .map((Department e) => DropdownMenuItem<String>(
                          value: e.depId,
                          child: Text(e.name!),
                        ))
                    .toList(),
                selectedItem: dep.selectDep,
                hint: 'Department',
                onChange: (String? value) => dep.onChange(value),
                onPressIcon: () => registerDepartment(context),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: CustomInkWellButton(
                  onTap: () {
                    if (_key.currentState!.validate() &&
                        dep.selectDep != null) {
                      final DoctorInfo doctor = DoctorInfo(
                        doctorID: const Uuid().v1(),
                        name: _name.text.trim(),
                        fee: double.parse(_fee.text.trim()),
                        depID: dep.selectDep,
                      );
                      DoctorInfoAPI().addDoctor(doctor);
                      Navigator.of(context).pushReplacementNamed(
                        HomeScreen.routeName,
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
