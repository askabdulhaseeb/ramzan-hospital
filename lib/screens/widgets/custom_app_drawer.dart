import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ramdazhospital/database/auth.dart';
import 'package:ramdazhospital/database/user_local_data.dart';
import 'package:ramdazhospital/screens/login_screen/login_screen.dart';
import 'package:ramdazhospital/screens/register_doctor/register_doctor.dart';
import 'package:ramdazhospital/screens/register_patient/register_patient.dart';
import 'package:ramdazhospital/screens/widgets/circular_profile_image.dart';
import 'package:ramdazhospital/screens/widgets/copyright.dart';
import 'package:ramdazhospital/screens/widgets/custom_textformfield.dart';
import 'package:ramdazhospital/screens/widgets/register_department.dart';
import 'package:ramdazhospital/utilities/utilities.dart';

import 'register_treatment.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({
    Key? key,
  }) : super(key: key);
  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            _userHeaderDetails(),
            const Divider(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.manage_accounts),
                    title: const Text('Add User'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.work),
                    title: const Text('Add Department'),
                    onTap: () {
                      registerDepartment(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.text_rotate_up_outlined),
                    title: const Text('Register Treatment'),
                    onTap: () {
                      registerTreatment(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Register Doctor'),
                    onTap: () => Navigator.of(context)
                        .pushNamed(RegisterDoctorScreen.routeName),
                  ),
                  ListTile(
                    leading: const Icon(Icons.airline_seat_flat),
                    title: const Text('Register Patient'),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RegisterPatientScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                AuthMethod().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (Route<dynamic> route) => false);
              },
            ),
            Copyrights(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Padding _userHeaderDetails() {
    return Padding(
      padding: EdgeInsets.all(Utilities.padding),
      child: Row(
        children: <Widget>[
          CircularProfileImage(
            imageUrl: UserLocalData.getUserImageUrl,
            radius: 46,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  UserLocalData.getUserDisplayName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 24, letterSpacing: 1),
                ),
                Text(
                  UserLocalData.getUserEmail,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
