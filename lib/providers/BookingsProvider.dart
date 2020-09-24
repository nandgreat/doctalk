import 'dart:convert';
import 'dart:io';

import 'package:doctalk/models/bookings_response.dart';
import 'package:doctalk/models/set_booking_response.dart';
import 'package:doctalk/models/specialty_doctors_response.dart';
import 'package:doctalk/utils/network_provider.dart';
import 'package:flutter/cupertino.dart';

class BookingsProvider extends ChangeNotifier {
  BookingsResponse _bookingsResponse;

  Future<BookingsResponse> fetchDoctorSpecialty() async {
    Map<String, String> _headerMap = Map<String, String>();
    _headerMap['Accept'] = 'application/json';
    _headerMap['content-type'] = 'application/json';

    final response = await doctorSpecialities(path: 'specialtys', header: null);
    print(response.toString());

    BookingsResponse responseJson =
        BookingsResponse.fromJson(json.decode(response));
    return responseJson;
  }

  Future<BookingsResponse> getAvailableBookings(String doctorId) async {
    Map<String, String> _map = Map<String, String>();
    _map['docid'] = doctorId;

    Map<String, String> _headerMap = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    final response = await makePostFetchRequets(
        path: 'availablebookings', map: _map, header: _headerMap);
    print("------------------------------${response.toString()}");

    BookingsResponse responseJson =
        BookingsResponse.fromJson(json.decode(response));
    return responseJson;
  }
  Future<SetBookingResponse> setBooking(String ref, String amount, String calid, String docid, String token) async {
    Map<String, String> _map = Map<String, String>();
    _map['ref'] = ref;
    _map['amount'] = amount;
    _map['calid'] = calid;
    _map['docid'] = docid;

    Map<String, String> _headerMap = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await makePostFetchRequets(
        path: 'availablebookings', map: _map, header: _headerMap);
    print("------------------------------${response.toString()}");

    SetBookingResponse responseJson =
    SetBookingResponse.fromJson(json.decode(response));
    return responseJson;
  }
}
