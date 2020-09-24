
/// name : "Eye Test"

class Spec {
  String _name;

  String get name => _name;

  Spec({
    String name}){
    _name = name;
  }

  Spec.fromJson(dynamic json) {
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    return map;
  }

}