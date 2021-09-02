class DoctorInfo {
  DoctorInfo({this.doctorID, this.name, this.fee, this.depID, this.addedBy});
  String? doctorID;
  String? name;
  double? fee;
  String? depID;
  String? addedBy;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctor_id': doctorID,
      'name': name,
      'fee': fee,
      'dep_id': depID,
      'added_by': addedBy,
    };
  }

  // ignore: sort_constructors_first
  factory DoctorInfo.fromMap(Map<String, dynamic> map) {
    return DoctorInfo(
      doctorID: map['doctor_id'].toString(),
      name: map['name'].toString(),
      fee: double.parse(map['fee'].toString()),
      depID: map['dep_id'].toString(),
      addedBy: map['added_by'].toString(),
    );
  }
}
