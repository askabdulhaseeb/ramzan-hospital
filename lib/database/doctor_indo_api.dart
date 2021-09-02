import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ramdazhospital/models/doctor_info.dart';

class DoctorInfoAPI {
  static const String _colloection = 'doctor_info';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<void> addDoctor(DoctorInfo doctor) async {
    _instance.collection(_colloection).doc(doctor.doctorID).set(doctor.toMap());
  }

}
