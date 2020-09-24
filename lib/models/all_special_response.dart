import 'package:doctalk/models/Spec.dart';

/// spec : [{"name":"Eye Test"},{"name":"Dentist"}]

class AllSpecialResponse {
  List<Spec> _spec;

  List<Spec> get spec => _spec;

  AllSpecialResponse({
      List<Spec> spec}){
    _spec = spec;
}

  AllSpecialResponse.fromJson(dynamic json) {
    if (json["spec"] != null) {
      _spec = [];
      json["spec"].forEach((v) {
        _spec.add(Spec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_spec != null) {
      map["spec"] = _spec.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
