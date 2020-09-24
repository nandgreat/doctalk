import 'dart:convert';

import 'package:doctalk/models/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'commons.dart';
import 'failure.dart';

/// Method for making post requests
Future<String> makeLoginRequest(
    {@required String path, @required Map map, @required Map header}) async {
  String url = '${Commons.apiBaseURL}$path';
  print("my url and map is: $url \n $map");
  try {
    return await http
        .post(url, body: map, headers: header ?? null)
        .timeout(Duration(seconds: Commons.timeOut))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      print("our res ${response.statusCode}");

      if (statusCode < 200 || json == null) {
        throw "Error while fetching data";
      } else if (statusCode == 401) {
        throw "Invalid Username or password";
      } else if (statusCode == 403) {
        throw "User not Verified";
      }
      print("provider response body: ${response.body}");
      return response.body;
    });
  } on Exception catch (e) {
    print("my new error is ${e.runtimeType}");
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

/// Method for making post requests
Future<String> otpVerifyRequest(
    {@required String path, @required Map map, @required Map header}) async {
  String url = '${Commons.apiBaseURL}$path';
  print("my url and map is: $url \n $map");
  try {
    return await http
        .post(url, body: map, headers: header ?? null)
        .timeout(Duration(seconds: Commons.timeOut))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      print("our res ${response.statusCode}");

      if (statusCode < 200 || json == null) {
        throw "Error while fetching data";
      } else if (statusCode == 401) {
        throw "Invalid Otp";
      } else if (statusCode == 403) {
        throw "User not Verified";
      }
      print("provider response body: ${response.body}");
      return response.body;
    });
  } on Exception catch (e) {
    print("my new error is ${e.runtimeType}");
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

/// Method for making post requests
Future<String> makePostFetchRequets({@required String path, @required Map map, @required Map header}) async {
  String url = '${Commons.apiBaseURL}$path';
  print("my url and map is: $url \n $map");
  var mybody = jsonEncode(map);

  try {
    return await http
        .post(url, body: mybody, headers: header ?? null)
        .timeout(Duration(seconds: Commons.timeOut))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      print("our res ${response.statusCode}");

      if (statusCode < 200 || json == null) {
        throw "Error while fetching data";
      } else if (statusCode == 401) {
        throw "Unauthorized request";
      } else if (statusCode == 403) {
        throw "Unauthorized";
      }
      print("provider response body: ${response.body}");
      return response.body;
    });
  } on Exception catch (e) {
    print("my new error is ${e.runtimeType}");
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

/// Method for making post requests
Future<String> doctorSpecialities({@required String path, @required Map header}) async {
  String url = '${Commons.apiBaseURL}$path';
  try {
    return await http
        .get(url, headers: header ?? null)
        .timeout(Duration(seconds: Commons.timeOut))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      print("our res ${response.statusCode}");

      if (statusCode < 200 || json == null) {
        throw "Error while fetching data";
      } else if (statusCode == 401) {
        throw "Invalid Otp";
      } else if (statusCode == 403) {
        throw "User not Verified";
      }
      print("provider response body: ${response.body}");
      return response.body;
    });
  } on Exception catch (e) {
    print("my new error is ${e.runtimeType}");
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

/// Method for making post requests
Future<String> signupPostRequest(
    {@required String path, @required Map map, @required Map header}) async {
  String url = '${Commons.apiBaseURL}$path';
  print("my url and map is: $url \n $map");
  try {
    return await http
        .post(url, body: map, headers: header ?? null)
        .timeout(Duration(seconds: Commons.timeOut))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      print("our res ${response.statusCode}");

      if (statusCode < 200 || json == null) {
        throw "Error while fetching data";
      } else if (statusCode == 401) {
        throw "User already exists";
      }
      // print("provider response body: ${response.body}");
      return response.body;
    });
  } on Exception catch (e) {
    print("my new error is ${e.runtimeType}");
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

/// Method for making put requests
Future<String> makePutRequest(
    {@required String path, @required Map map, @required Map header}) async {
  String url = '${Commons.baseURL}$path';
  try {
    return await http
        .put(url, body: map, headers: header ?? null)
        .timeout(Duration(seconds: Commons.timeOut))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || json == null) {
        throw "Error while fetching data";
      }
      return response.body;
    });
  } on Exception catch (e) {
    throw FailureException(e);
  }
}

/// Method for making get requests
Future<String> makeGetRequest(
    {@required String path, @required Map header}) async {
  String url = '${Commons.baseURL}$path';
  try {
    return await http
        .get(url, headers: header ?? null)
        .timeout(Duration(seconds: Commons.timeOut))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || json == null) {
        throw "Error while fetching data";
      }
      return response.body;
    });
  } on Exception catch (e) {
    throw FailureException(e);
  }
}
