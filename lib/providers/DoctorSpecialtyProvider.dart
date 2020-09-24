import 'dart:convert';
import 'dart:io';

import 'package:doctalk/models/all_special_response.dart';
import 'package:doctalk/models/specialty_doctors_response.dart';
import 'package:doctalk/utils/network_provider.dart';
import 'package:flutter/cupertino.dart';

class DoctorSpecialtyProvider extends ChangeNotifier {
  AllSpecialResponse chuckCategories;

  Future<AllSpecialResponse> fetchDoctorSpecialty() async {

    Map<String, String> _headerMap = Map<String, String>();
    _headerMap['Accept'] = 'application/json';
    _headerMap['content-type'] = 'application/json';

    final response =
    await doctorSpecialities(path: 'specialtys', header: null);
    print(response.toString());

    AllSpecialResponse responseJson = AllSpecialResponse.fromJson(json.decode(response));
    return responseJson;
  }

  Future<SpecialtyDoctorsResponse> getSpecialtyDoctors(String specialty) async {

    Map<String, String> _map = Map<String, String>();
    _map['name'] = specialty;

    Map<String, String> _headerMap = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Accept': 'application/json',
    };

    final response = await makePostFetchRequets(path: 'search_spec', map: _map, header: _headerMap);
    print("------------------------------${response.toString()}");

    SpecialtyDoctorsResponse responseJson = SpecialtyDoctorsResponse.fromJson(json.decode(response));
    return responseJson;
  }
}
