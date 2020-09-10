import 'package:doctalk/models/user.dart';
import 'package:doctalk/providers/AuthProvider.dart';
import 'package:doctalk/utils/commons.dart';
import 'package:doctalk/view/dashboard.dart';
import 'package:doctalk/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    _userPassword = TextEditingController(text: "");
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/doc_talk.png'),
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    children: <Widget>[
                      _emailField(),
                      SizedBox(
                        height: 20,
                      ),
                      _passwordField(),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 30.0),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
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
                      "Don't have an Account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                      },
                      child: Text(
                        "Register",
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            hintText: 'Username'),
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
            child: Commons.chuckyLoading("Loggin in"),
          )
        : InkWell(
            onTap: () async {
              if (_formPageKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                try {
                  String username = _userName.text;
                  String password = _userPassword.text;

                  final newUser =
                      Provider.of<AuthProvider>(context, listen: false)
                          .mylogin(username, password);
                  newUser.then((value) {
                    if (value != null)
                      _loginWithPhoneAndPassword(value, context);
                  }).catchError((e) {
                    print("catchy error ${e.toString()}");
                    // Commons.showError(context, e.toString());
                    setState(() => isLoading = false);
                    _pageKey.currentState.showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  });
                } catch (e) {
                  Commons.showError(context, e.message);
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
                    child: Text("Login"),
                  ))),
            ),
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

  Widget _socialButtons(String socialMedia, BuildContext context) {
    return InkWell(
      onTap: () {
        print("login clicked $socialMedia");
      },
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
                    socialMedia.capitalize(),
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
