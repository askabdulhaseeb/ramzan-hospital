import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient_info.dart';
import '../utilities/custom_toast.dart';

class PatientInfoAPI {
  static const String _colloection = 'patientsInfo';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<void> addPatient(PatientInfo patient) async {
    await _instance
        .collection(_colloection)
        .doc(patient.patientId)
        .set(patient.toMap())
        .catchError((Object e) {
      CustomToast.errorToast(message: e.toString());
    });
  }

  Future<List<PatientInfo>> getPatients() async {
    final QuerySnapshot<Map<String, dynamic>> docs =
        await _instance.collection(_colloection).get();
    final List<PatientInfo> patient = <PatientInfo>[];
    // ignore: avoid_function_literals_in_foreach_calls
    docs.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {
      patient.add(PatientInfo.fromDocument(element));
    });
    return patient;
  }
}
