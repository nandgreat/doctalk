import 'dart:async';

import 'package:doctalk/models/user.dart';
import 'package:doctalk/providers/AuthProvider.dart';
import 'package:doctalk/utils/colors.dart';
import 'package:doctalk/utils/commons.dart';
import 'package:doctalk/view/dashboard.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';


class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;

  PinCodeVerificationScreen({String phone, this.phoneNumber, this.email});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  bool isLoading = false;
  final _pageKey = GlobalKey<ScaffoldState>();
  String errorMessage;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorMessage = "";
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: _pageKey,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  "assets/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Phone Number Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: widget.phoneNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 70),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      textInputType: TextInputType.number,
                      obsecureText: false,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        inactiveColor: Colors.white,
                        borderWidth: 2.0,
                        inactiveFillColor: Colors.white,
                        activeFillColor:
                            hasError ? Colors.orange : Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? errorMessage : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: " RESEND",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: Color(0xFF91D3B3),
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
              SizedBox(
                height: 14,
              ),
              _otpButton(context),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Clear"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpButton(BuildContext context) {
    return isLoading
        ? Center(
            child: Commons.otpLoading("Verifying OTP"),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
            child: ButtonTheme(
              height: 50,
              child: FlatButton(
                onPressed: () async {
                  formKey.currentState.validate();
                  // conditions for validating
                  if (currentText.length != 4) {
                    errorController.add(ErrorAnimationType
                        .shake); // Triggering error shake animation
                    setState(() {
                      hasError = true;
                    });
                  } else {
                    if (formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        var otp = textEditingController.text;

                        final otpResponse =
                            Provider.of<AuthProvider>(context, listen: false)
                                .otpVerification(otp, widget.email);

                        otpResponse.then((value) {
                          if (value != null)
                            _loginWithPhoneAndPassword(value, context);
                        }).catchError((e) {
                          print("catchy error ${e.toString()}");
                          // Commons.showError(context, e.toString());
                          setState(() {
                            hasError = true;
                            isLoading = false;
                            errorMessage = e.toString();
                          });
                          errorController.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          // setState(() {
                          //   hasError = true;
                          // });
                          // _pageKey.currentState.showSnackBar(SnackBar(
                          //   content: Text(e.toString()),
                          //   duration: Duration(seconds: 2),
                          // ));
                        });
                      } catch (e) {
                        Commons.showError(context, e.toString());
                        setState(() => isLoading = false);
                        _pageKey.currentState.showSnackBar(SnackBar(
                          content: Text("Could not Login"),
                        ));
                      }
                    }
                  }
                },
                child: Center(
                    child: Text(
                  "VERIFY".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: MyColors.primaryColor,
                      offset: Offset(1, -2),
                      blurRadius: 5),
                  BoxShadow(
                      color: MyColors.primaryColor,
                      offset: Offset(-1, 2),
                      blurRadius: 5)
                ]),
          );
  }

  _loginWithPhoneAndPassword(User user, BuildContext context) {
    final storage = FlutterSecureStorage();
    storage.write(key: "loginstatus", value: "loggedin");
    storage.write(key: "email", value: user.email);
    storage.write(key: "fullname", value: user.fullname);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
  }
}
