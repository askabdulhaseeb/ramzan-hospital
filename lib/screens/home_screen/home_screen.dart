import 'package:flutter/material.dart';
import 'package:ramdazhospital/database/patient_info_api.dart';
import 'package:ramdazhospital/database/user_local_data.dart';
import 'package:ramdazhospital/models/patient_info.dart';
import 'package:ramdazhospital/screens/widgets/circular_profile_image.dart';
import 'package:ramdazhospital/screens/widgets/custom_app_drawer.dart';
import 'package:ramdazhospital/utilities/utilities.dart';
import 'total_overview_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          CircularProfileImage(imageUrl: UserLocalData.getUserImageUrl),
          const SizedBox(width: 20),
        ],
      ),
      drawer: const CustomAppDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: Utilities.padding),
            const TotalOverviewCardWidget(
              amount: 60000,
              noOfPatient: 122,
              date: '14/04/2021',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                'DETAILS',
                style: TextStyle(letterSpacing: 1, color: Colors.blueGrey),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: PatientInfoAPI().getPatients(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<PatientInfo>?> snapshot,
                ) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        const Text('data'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Patient',
        child: const Icon(Icons.add),
      ),
    );
  }
}
