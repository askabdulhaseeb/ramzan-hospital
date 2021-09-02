import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramdazhospital/models/department.dart';
import 'package:ramdazhospital/providers/department_provider.dart';
import 'package:ramdazhospital/screens/home_screen/home_screen.dart';
import 'package:ramdazhospital/screens/widgets/custom_dropdown.dart';
import 'package:ramdazhospital/screens/widgets/custom_inkwell_button.dart';
import 'package:ramdazhospital/screens/widgets/custom_textformfield.dart';
import 'package:ramdazhospital/screens/widgets/register_department.dart';
import 'package:ramdazhospital/utilities/custom_validator.dart';
import 'package:ramdazhospital/utilities/utilities.dart';

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
              Consumer<DepartmentProvider>(
                builder: (
                  BuildContext context,
                  DepartmentProvider dep,
                  Widget? child,
                ) =>
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
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: CustomInkWellButton(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName,
                      (Route<dynamic> route) => false,
                    );
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
