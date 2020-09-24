
/// firstname : "Godspower"
/// lastname : "Patrick"
/// id : 1
/// photo : "1596195811.jpeg"
/// country : "Antartica"
/// state : "Antartica"
/// about : "Gg"
/// specialty : "dentist"
/// amount : 9000
/// phone : "08074725983"

class Doctors {
  String _firstname;
  String _lastname;
  int _id;
  String _photo;
  String _country;
  String _state;
  String _about;
  String _specialty;
  int _amount;
  String _phone;

  String get firstname => _firstname;
  String get lastname => _lastname;
  int get id => _id;
  String get photo => _photo;
  String get country => _country;
  String get state => _state;
  String get about => _about;
  String get specialty => _specialty;
  int get amount => _amount;
  String get phone => _phone;

  Doctors({
    String firstname,
    String lastname,
    int id,
    String photo,
    String country,
    String state,
    String about,
    String specialty,
    int amount,
    String phone}){
    _firstname = firstname;
    _lastname = lastname;
    _id = id;
    _photo = photo;
    _country = country;
    _state = state;
    _about = about;
    _specialty = specialty;
    _amount = amount;
    _phone = phone;
  }

  Doctors.fromJson(dynamic json) {
    _firstname = json["firstname"];
    _lastname = json["lastname"];
    _id = json["id"];
    _photo = json["photo"];
    _country = json["country"];
    _state = json["state"];
    _about = json["about"];
    _specialty = json["specialty"];
    _amount = json["amount"];
    _phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["firstname"] = _firstname;
    map["lastname"] = _lastname;
    map["id"] = _id;
    map["photo"] = _photo;
    map["country"] = _country;
    map["state"] = _state;
    map["about"] = _about;
    map["specialty"] = _specialty;
    map["amount"] = _amount;
    map["phone"] = _phone;
    return map;
  }

}