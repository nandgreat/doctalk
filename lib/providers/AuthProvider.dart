import 'dart:convert';

import 'package:doctalk/models/login_response.dart';
import 'package:doctalk/models/register_response.dart';
import 'package:doctalk/models/user.dart';
import 'package:doctalk/utils/commons.dart';
import 'package:doctalk/utils/network_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class AuthProvider extends ChangeNotifier {
  LoginResponse _loginResponse;
  User user;
  // RegisterResponse _registerResponse;

  Future<User> mylogin(String username, String password) async {
    Map<String, String> _map = Map<String, String>();
    _map['username'] = username;
    _map['password'] = password;

    Map<String, String> _headerMap = Map<String, String>();
    _headerMap['Accept'] = 'application/json';
    _headerMap['content-type'] = 'application/json';

    print("my map is: $_map");

    final response =
        await makePostRequest(path: 'login', map: _map, header: null);
    print(response.toString());

    LoginResponse responseJson = LoginResponse.fromJson(json.decode(response));
    return responseJson.user;
  }

  Future<User> otpVerification(String otp, String email) async {
    Map<String, String> _map = Map<String, String>();
    _map['otp'] = otp;
    _map['email'] = email;

    Map<String, String> _headerMap = Map<String, String>();
    _headerMap['Accept'] = 'application/json';
    _headerMap['content-type'] = 'application/json';

    print("my map is: $_map");

    final response =
        await otpVerifyRequest(path: 'otpverify', map: _map, header: null);
    print(response.toString());

    LoginResponse responseJson = LoginResponse.fromJson(json.decode(response));
    return responseJson.user;
  }

  Future<RegisterResponse> signup(String username, String email, String country,
      String state, String phone, String name, String password) async {
    Map<String, String> _map = Map<String, String>();
    _map['username'] = username;
    _map['password'] = password;
    _map['phone'] = phone;
    _map['name'] = name;
    _map['country'] = country;
    _map['state'] = state;
    _map['email'] = email;

    print("my map is: $_map");

    Map<String, String> _headerMap = Map<String, String>();
    _headerMap['Accept'] = 'application/json';
    _headerMap['content-type'] = 'application/json';

    final response =
        await signupPostRequest(path: 'register', map: _map, header: null);
    // print(response.toString());

    print("my response is $response");

    RegisterResponse responseJson =
        RegisterResponse.fromJson(json.decode(response));
    return responseJson;
  }

  Future<User> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Commons.apiBaseURL + "login",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        var responseJson = Commons.returnResponse(response);
        _loginResponse = LoginResponse.fromJson(responseJson);
        user = _loginResponse.user;
        print("my fullname is ${user.fullname}");
        return user;
      } else {
        print(response.statusCode);
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}
