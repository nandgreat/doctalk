import 'package:doctalk/view/login_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Color(0xFF1686AA),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Center(
              child: Image(
                image: AssetImage('assets/doc_talk.png'),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    "WELCOME",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: Text(
                      "Sign in to Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: InkWell(
                    onTap: () {
                      print("This thing is working");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Center(
                      child: Container(
                        height: 40.0,
                        width: 250.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Sign in with Mobile',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 155.0),
                  child: Center(
                    child: Text(
                      "Or",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 190.0, 8.0, 8.0),
                  child: Center(
                    child: Container(
                      height: 40.0,
                      width: 250.0,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print("This thing is working");
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFF1686AA),
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Sign in with facebook',
                                style: TextStyle(color: Color(0xFF1686AA)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
