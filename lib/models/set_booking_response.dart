/// message : "SuccessFully Booked!"

class SetBookingResponse {
  String _message;

  String get message => _message;

  SetBookingResponse({
      String message}){
    _message = message;
}

  SetBookingResponse.fromJson(dynamic json) {
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    return map;
  }

}