import 'package:doctalk/utils/colors.dart';
import 'package:doctalk/utils/commons.dart';
import 'package:doctalk/view/buy_drugs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'consultation.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String email;
  String fullname;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    setState(() {
      this.email = "";
      this.fullname = "";
    });

    getUserDetails();
  }

  void getUserDetails() async {
    // this.email = await storage.read(key: "email");
    // this.fullname = await storage.read(key: "fullname");

    loadData();
    loadEmail();
  }

  loadData() async {
    var myfullname = await storage.read(key: "fullname");
    setState(() => this.fullname = myfullname);
  }

  loadEmail() async {
    var myemail = await storage.read(key: "email");
    setState(() => this.email = myemail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(""),
        elevation: 0.0,
        backgroundColor: Color(0xFF1686AA),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment(0.0, -0.40),
                    height: 150.0,
                    decoration: BoxDecoration(color: Color(0xFF1686AA)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 10.0, 20.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'DOCTALK',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                width: 120.0,
                                margin: EdgeInsets.only(top: 35.0),
                                child: Text(
                                  'Changing the way you recieve Healthcare with Medical Excellence',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 18.0),
                            child: Container(
                              child: Image(
                                  image:
                                      AssetImage("assets/dashboard_image.png")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              GridView.count(
                crossAxisCount: 2,
                primary: false,
                childAspectRatio: 10 / 9,
                crossAxisSpacing: 2.0,
                shrinkWrap: true,
                children: <Widget>[
                  dashBoardItem('health_funding.png', 'Health Funding', 1),
                  dashBoardItem('doctor.png', 'Live Consultation', 2),
                  dashBoardItem('health_forum.png', 'Health Forum', 3),
                  dashBoardItem('buy_drugs.png', 'Buy Drugs', 4),
                  dashBoardItem('online_training.png', 'Online Training', 5),
                  dashBoardItem('blog.png', 'Blog', 6),
                ],
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/default_user.jpg'),
                    radius: 30.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    fullname,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 16.0),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
              ),
            ),
            ListTile(
              title: Text('Heath Funding'),
              leading: Icon(Icons.attach_money),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Buy Drugs'),
              leading: Icon(Icons.satellite),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Live Consultation'),
              leading: Icon(Icons.live_tv),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Appointment'),
              leading: Icon(Icons.event_note),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Commons.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dashBoardItem(String image, String name, int cardIndex) {
    return InkWell(
      onTap: () {
        if (cardIndex == 2) {
          print(name);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Consultation()));
        } else if (cardIndex == 4) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BuyDrugs()));
        }
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: MyColors.primaryColor,
          elevation: 4.0,
          child: Container(
            height: 170.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/' + image,
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          margin: cardIndex.isEven
              ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 25.0)
              : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 25.0)),
    );
  }
}
