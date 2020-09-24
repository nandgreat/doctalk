import 'booking.dart';

/// booking : [{"day":"taken","start":"taken","end":"taken","id":"taken"},{"day":"monday","start":"11:39","end":"11:39","id":2},{"day":"taken","start":"taken","end":"taken","id":"taken"},{"day":"monday","start":"02:40","end":"09:40","id":4},{"day":"taken","start":"taken","end":"taken","id":"taken"},{"day":"friday","start":"05:42","end":"08:42","id":6},{"day":"thursday","start":"12:27","end":"18:27","id":8},{"day":"wednesday","start":"12:30","end":"20:30","id":10},{"day":"saturday","start":"13:32","end":"18:32","id":11},{"day":"monday","start":"05:06","end":"08:09","id":12},{"day":"sunday","start":"02:03","end":"05:06","id":13},{"day":"thursday","start":"16:06","end":"06:08","id":14},{"day":"thursday","start":"16:06","end":"06:08","id":15},{"day":"friday","start":"05:04","end":"19:09","id":16},{"day":"tuesday","start":"12:12","end":"14:34","id":17},{"day":"tuesday","start":"12:12","end":"14:34","id":18},{"day":"tuesday","start":"12:12","end":"14:34","id":19},{"day":"tuesday","start":"12:12","end":"14:34","id":20},{"day":"tuesday","start":"12:12","end":"14:34","id":21},{"day":"tuesday","start":"12:12","end":"14:34","id":22},{"day":"tuesday","start":"12:12","end":"14:34","id":23},{"day":"tuesday","start":"12:12","end":"14:34","id":24},{"day":"tuesday","start":"12:12","end":"14:34","id":25},{"day":"wednesday","start":"15:59","end":"17:01","id":26},{"day":"sunday","start":"05:59","end":"09:59","id":27}]

class BookingsResponse {
  List<Booking> _booking;

  List<Booking> get booking => _booking;

  BookingsResponse({
      List<Booking> booking}){
    _booking = booking;
}

  BookingsResponse.fromJson(dynamic json) {
    if (json["booking"] != null) {
      _booking = [];
      json["booking"].forEach((v) {
        _booking.add(Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_booking != null) {
      map["booking"] = _booking.map((v) => v.toJson()).toList();
    }
    return map;
  }

}