import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ramdazhospital/models/treatments.dart';
import 'package:ramdazhospital/utilities/custom_toast.dart';

class TreatmentAPI {
  static const String _collection = 'treatments';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<void> addTreatment(Treatment treatment) async {
    _instance
        .collection(_collection)
        .doc(treatment.treatmentId)
        .set(treatment.toMap())
        .catchError((dynamic e) {
      CustomToast.errorToast(message: e.toString());
    });
  }
}
