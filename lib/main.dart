import 'package:doctalk/providers/AuthProvider.dart';
import 'package:doctalk/view/dashboard.dart';
import 'package:doctalk/view/home_page.dart';
import 'package:doctalk/view/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    run();
  });
}

void run() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        theme: buildTheme(),
        home: SplashScreen(),
      ),
    );
  }

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        labelStyle: TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    checkLoginStatus();
  }

  Future checkLoginStatus() async {
    final storage = FlutterSecureStorage();
    String loggedIn = await storage.read(key: "loginstatus");
    String email = await storage.read(key: "email");
    String phone = await storage.read(key: "phone");
    if (loggedIn == null || loggedIn == "loggedout") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } else if (loggedIn == "otp") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PinCodeVerificationScreen(
                phone: phone,
                email: email,
              )));
    } else {
      if (loggedIn == "loggedin") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
