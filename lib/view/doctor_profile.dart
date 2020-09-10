import 'package:doctalk/models/doctors.dart';
import 'package:doctalk/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorProfile extends StatefulWidget {
  final Doctor doctor;

  DoctorProfile({this.doctor});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              color: MyColors.primaryColor,
              child: Column(
                children: [
                  Text(
                    widget.doctor.doctorName,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                  Text(
                    widget.doctor.specialty,
                    style: TextStyle(color: Colors.grey[300], fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.phone,
                            ),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(75),
                                color: Colors.transparent),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 136.0,
                                  width: 136.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(68),
                                      color: Colors.transparent),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 120.0,
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            color: Colors.transparent),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/doctor_jane.png"),
                                          radius: 100.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(
                              'assets/chat_bubble.svg',
                            ),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("₦${widget.doctor.amount}",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            Text("${widget.doctor.experienceYears} Years exp.",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            Text("${widget.doctor.numFavourite} likes",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 1 / 2,
            child: ListView(
              padding: EdgeInsets.only(left: 20.0),
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: MyColors.primaryColor,
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 45.0),
                  unselectedLabelColor: Color(0xFFCDCDCD),
                  tabs: [
                    Tab(
                      child: Text(
                        "Doctor's Info",
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Clinic Info',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Feedback',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 50,
                  width: double.infinity,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Text("Doctor's Info"),
                      Text("Clinic Info"),
                      Text("Feedback"),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
