/// day : "taken"
/// start : "taken"
/// end : "taken"
/// id : "taken"

class Booking {
  String _day;
  String _start;
  String _end;
  String _id;

  String get day => _day;
  String get start => _start;
  String get end => _end;
  String get id => _id;

  Booking({
      String day, 
      String start, 
      String end, 
      String id}){
    _day = day;
    _start = start;
    _end = end;
    _id = id;
}

  Booking.fromJson(dynamic json) {
    _day = json["day"];
    _start = json["start"];
    _end = json["end"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["day"] = _day;
    map["start"] = _start;
    map["end"] = _end;
    map["id"] = _id;
    return map;
  }

}