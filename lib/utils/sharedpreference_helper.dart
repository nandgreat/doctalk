import 'dart:convert';

import 'package:doctalk/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferences _preferences;

  /// Saves users value irrespective of its value
  void saveValue({@required String key, @required value}) async {
    _preferences = await SharedPreferences.getInstance();

    if (value is String) {
      _preferences.setString(key, value);
      return;
    }

    if (value is int) {
      _preferences.setInt(key, value);
      return;
    }

    if (value is bool) {
      _preferences.setBool(key, value);
      return;
    }

    if (value is double) {
      _preferences.setDouble(key, value);
      return;
    }

    if (value is List<String>) {
      _preferences.setStringList(key, value);
      return;
    }

    if (value is Map) {
      _preferences.setString(key, json.encode(value));
      return;
    }
  }

  /// get string values
  Future<String> getStringValues({@required String key}) async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(key) ?? null;
  }

  /// get string values
  Future<bool> getBoolValues({@required String key}) async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool(key) ?? false;
  }

  /// get int values
  Future<int> getIntValues({@required String key}) async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getInt(key) ?? 0;
  }

  /// get double values
  Future<double> getDoubleValues({@required String key}) async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getDouble(key) ?? 0.0;
  }

  Future<User> getData({@required String key}) async {
    _preferences = await SharedPreferences.getInstance();
    final _response = await json.decode(_preferences.getString(key)) ?? null;
    return User.fromJson(_response);
  }

  Future<void> remove() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
  }
}
