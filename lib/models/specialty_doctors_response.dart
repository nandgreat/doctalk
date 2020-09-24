import 'doctors.dart';

/// doctors : [{"firstname":"Godspower","lastname":"Patrick","id":1,"photo":"1596195811.jpeg","country":"Antartica","state":"Antartica","about":"Gg","specialty":"dentist","amount":9000,"phone":"08074725983"}]

class SpecialtyDoctorsResponse {
  List<Doctors> _doctors;

  List<Doctors> get doctors => _doctors;

  SpecialtyDoctorsResponse({
      List<Doctors> doctors}){
    _doctors = doctors;
}

  SpecialtyDoctorsResponse.fromJson(dynamic json) {
    if (json["doctors"] != null) {
      _doctors = [];
      json["doctors"].forEach((v) {
        _doctors.add(Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_doctors != null) {
      map["doctors"] = _doctors.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
