class RegisterResponse {
  String message;
  int userid;

  RegisterResponse({this.message, this.userid});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userid'] = this.userid;
    return data;
  }
}
