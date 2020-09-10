import 'package:doctalk/providers/AuthProvider.dart';
import 'package:doctalk/utils/commons.dart';
import 'package:doctalk/view/login_screen.dart';
import 'package:doctalk/view/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

extension StringExtension on String {
  String capitalizer() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _name;
  TextEditingController _mobileNumber;
  TextEditingController _email;
  TextEditingController _userName;
  TextEditingController _userPassword;
  TextStyle style =
      TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 18.0);
  bool isLoading = false;
  final _formPageKey = GlobalKey<FormState>();
  final _pageKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _userName = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _userPassword = TextEditingController(text: "");
    _mobileNumber = TextEditingController(text: "");
    _name = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _pageKey,
        backgroundColor: Color(0xFF1686AA),
        body: Form(
          key: _formPageKey,
          child: ListView(primary: true, children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                // Center(
                //   child: Image(
                //     image: AssetImage('assets/doc_talk.png'),
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Patient Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      ),
                      Text(
                        "Are you a Doctor?",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    children: <Widget>[
                      _nameField(),
                      SizedBox(
                        height: 20,
                      ),
                      _mobileField(),
                      SizedBox(
                        height: 20,
                      ),
                      _emailField(),
                      SizedBox(
                        height: 20,
                      ),
                      _myUserName(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // _dateOfBirthInput(),
                      SizedBox(
                        height: 20,
                      ),
                      _passwordField(),
                    ],
                  ),
                ),
                SizedBox(height: 25.0),
                _loginButton(context),
                SizedBox(height: 30.0),
                Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _socialButtons('facebook', context),
                      _socialButtons('gmail', context),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an Account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ]),
        ));
  }

  // Widget _emailPasswordWidget() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width - 50,
  //     child: Column(
  //       children: <Widget>[
  //         _emailField(),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         _passwordField(),
  //       ],
  //     ),
  //   );
  // }

  Widget _emailField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        key: Key("userName"),
        keyboardType: TextInputType.emailAddress,
        style: style,
        controller: _email,
        cursorColor: Colors.white,
        decoration: new InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.white),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  color: Colors.white, width: 2.0, style: BorderStyle.solid)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        ),
      ),
    );
  }

  Widget _nameField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        key: Key("name"),
        keyboardType: TextInputType.text,
        style: style,
        controller: _name,
        cursorColor: Colors.white,
        decoration: new InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          labelText: "Name",
          labelStyle: TextStyle(color: Colors.white),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  color: Colors.white, width: 2.0, style: BorderStyle.solid)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        ),
      ),
    );
  }

  Widget _myUserName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        key: Key("name"),
        keyboardType: TextInputType.text,
        style: style,
        controller: _userName,
        cursorColor: Colors.white,
        decoration: new InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          labelText: "Username",
          labelStyle: TextStyle(color: Colors.white),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  color: Colors.white, width: 2.0, style: BorderStyle.solid)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        ),
      ),
    );
  }

  Widget _mobileField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        key: Key("mobile"),
        keyboardType: TextInputType.phone,
        style: style,
        controller: _mobileNumber,
        cursorColor: Colors.white,
        decoration: new InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          labelText: "Mobile Number",
          labelStyle: TextStyle(color: Colors.white),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  color: Colors.white, width: 2.0, style: BorderStyle.solid)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      key: Key("userPassword"),
      obscureText: true,
      controller: _userPassword,
      validator: (value) => (value.isEmpty) ? "Please Enter Password" : null,
      style: style,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        labelText: "Password",
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return isLoading
        ? Center(
            child: Commons.chuckyLoading("Registering User"),
          )
        : InkWell(
            onTap: () async {
              if (_formPageKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                try {
                  String username = _userName.text.toString();
                  String email = _email.text.toLowerCase();
                  String password = _userPassword.text.toString();
                  String phone = _mobileNumber.text;
                  String name = _name.text.toString();

                  final newUser =
                      Provider.of<AuthProvider>(context, listen: false).signup(
                          username,
                          email,
                          "nigeria",
                          "abuja",
                          phone,
                          name,
                          password);
                  newUser.then((value) {
                    if (value != null) {
                      print(value);
                      _signup(email, phone, context);
                    }
                  }).catchError((e) {
                    print("catchy error ${e.runtimeType}");
                    // Commons.showError(context, e.toString());
                    setState(() => isLoading = false);
                    _pageKey.currentState.showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  });
                } catch (e) {
                  Commons.showError(context, e.message());
                  setState(() => isLoading = false);
                  _pageKey.currentState.showSnackBar(SnackBar(
                    content: Text("Could not Login"),
                  ));
                }
              }
            },
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text("Sign up"),
                  ))),
            ),
          );
  }

  _signup(String email, String phone, BuildContext context) {
    final storage = FlutterSecureStorage();
    storage.write(key: "loginstatus", value: "otp");
    storage.write(key: "email", value: email);
    storage.write(key: "phone", value: phone);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PinCodeVerificationScreen(
                  phone: phone,
                  email: email,
                )));
  }

  Widget _socialButtons(String socialMedia, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white, style: BorderStyle.solid, width: 1.0),
              borderRadius: BorderRadius.circular(20.0)),
          width: MediaQuery.of(context).size.width / 2 - 40.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/$socialMedia.svg",
                    width: 18.0,
                    height: 18.0,
                    color: socialMedia == "facebook" ? Colors.white : null,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    socialMedia.capitalizer(),
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
