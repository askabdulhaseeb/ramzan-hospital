class DoctorInfo {
  DoctorInfo({
    this.doctorID,
    this.name,
    this.fee,
    this.depID,
    this.addedBy,
    this.status = true,
  });
  String? doctorID;
  String? name;
  double? fee;
  String? depID;
  String? addedBy;
  bool? status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctor_id': doctorID,
      'name': name,
      'fee': fee,
      'dep_id': depID,
      'added_by': addedBy,
      'status': status,
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
      status: bool.fromEnvironment(map['status'].toString()),
    );
  }
}
