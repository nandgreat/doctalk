import 'package:doctalk/models/doctors.dart';
import 'package:doctalk/utils/colors.dart';
import 'package:doctalk/view/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BuyDrugs extends StatefulWidget {
  final String title;

  BuyDrugs({this.title});

  @override
  _BuyDrugsState createState() => _BuyDrugsState();
}

class _BuyDrugsState extends State<BuyDrugs> {
  List<Doctors> doctors = [
    Doctors(
        firstname: "Prince",
        lastname: "David",
        specialty: "General Physician",
        photo: "prince.png",
        about: "MD - General Medicin, Abuja Teaching Hospital",
        amount: 15000,
        id: 1,
        country: "Antartica",
        phone: "07031676998")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Pharmacy"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: 50.0,
              color: MyColors.primaryColor,
            ),
            Card(
              elevation: 5.0,
              margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Search for Doctors',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ]),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              primary: true,
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        "Results showing for General Doctors",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[500]),
                      ),
                    ),
                    Column(
                      children: doctors
                          .map((doctor) => DoctorCard(
                                doctor: doctor,
                              ))
                          .toList(),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctors doctor;

  DoctorCard({this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 6.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("50"),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, left: 10.0, top: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 90.0,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/${doctor.photo}"),
                              radius: 23.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                          height: 90.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.firstname,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Container(
                                child: Text(
                                  "MD - General Medicine, Abuja Teaching Hospital",
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 12.0),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor.amount.toString(),
                                    style:
                                        TextStyle(color: MyColors.primaryColor),
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text("3 years exp.",
                                      style: TextStyle(
                                          color: MyColors.primaryColor)),
                                ],
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorProfile(doctor: doctor)));
                            },
                            child: Text("Profile",
                                style: TextStyle(color: Colors.white))),
                        Text("Call", style: TextStyle(color: Colors.white)),
                        Text("Book", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
