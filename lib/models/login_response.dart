import 'package:doctalk/models/user.dart';

import 'user.dart';

class LoginResponse {
  String message;
  String jwt;
  User user;

  LoginResponse({this.message, this.jwt, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    jwt = json['jwt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['jwt'] = this.jwt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
