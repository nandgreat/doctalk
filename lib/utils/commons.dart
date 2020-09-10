import 'dart:convert';
import 'package:doctalk/networking/AppException.dart';
import 'package:doctalk/utils/colors.dart';
import 'package:doctalk/utils/sharedpreference_helper.dart';
import 'package:doctalk/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Commons {
  static const baseURL = "https://api.chucknorris.io/";
  static const apiBaseURL = "http://161.35.90.86/api/";
  static const timeOut = 20;
  SharedPreferencesHelper preferencesHelper = new SharedPreferencesHelper();

  // static const apiBaseURL = "https://jiffix.jawharacloset.com/api/";

  static const usersPrefKey = "userKey";

  static const tileBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeWaveBackgroundColor = const Color(0xFFA8184B);
  static const gradientBackgroundColorEnd = const Color(0xFF601A36);
  static const gradientBackgroundColorWhite = const Color(0xFFFFFFFF);
  static const mainAppFontColor = const Color(0xFF4D0F29);
  static const appBarBackGroundColor = const Color(0xFF4D0F28);
  static const categoriesBackGroundColor = const Color(0xFFA8184B);
  static const hintColor = const Color(0xFF4D0F29);
  static const mainAppColor = const Color(0xFF4D0F29);
  static const gradientBackgroundColorStart = const Color(0xFF4D0F29);
  static const popupItemBackColor = const Color(0xFFDADADB);

  static Widget chuckyLoader() {
    return Center(
        child: SpinKitRing(
      size: 50.0,
      lineWidth: 5.0,
      color: Colors.white,
    ));
  }

  static Widget otpLoader() {
    return Center(
        child: SpinKitRing(
      size: 50.0,
      lineWidth: 5.0,
      color: MyColors.primaryColor,
    ));
  }

  static void showError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(message),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  static Widget chuckyLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            )),
        chuckyLoader(),
      ],
    );
  }

  static Widget otpLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              message,
              style: TextStyle(color: MyColors.primaryColor),
            )),
        otpLoader(),
      ],
    );
  }

  static Future logout(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
