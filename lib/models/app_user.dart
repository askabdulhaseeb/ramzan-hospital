import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.imageURL,
    required this.type,
    required this.status,
  });
  factory AppUser.fromDocuments(DocumentSnapshot<Map<String, dynamic>> docs) {
    return AppUser(
      uid: docs.data()!['uid'].toString(),
      email: docs.data()!['email'].toString(),
      displayName: docs.data()!['name'].toString(),
      imageURL: docs.data()!['imageURL'].toString(),
      type: docs.data()!['type'].toString(),
      status: bool.fromEnvironment(docs.data()!['status'].toString()),
    );
  }

  final String uid;
  final String email;
  final String displayName;
  final String imageURL;
  final String type;
  final bool status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': displayName,
      'imageURL': imageURL,
      'type': type,
      'status': status,
    };
  }
}
