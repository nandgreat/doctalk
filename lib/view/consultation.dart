import 'package:doctalk/models/Spec.dart';
import 'package:doctalk/providers/DoctorSpecialtyProvider.dart';
import 'package:doctalk/utils/colors.dart';
import 'package:doctalk/utils/commons.dart';
import 'package:doctalk/utils/strings.dart';
import 'package:doctalk/view/error_fetch.dart';
import 'package:doctalk/view/single_doctor_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctalk/models/all_special_response.dart';
import 'package:provider/provider.dart';


class Consultation extends StatefulWidget {
  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {

  bool isLoading = false;

  AllSpecialResponse specialtyResponse;
  List<Spec> specList;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Doctors'),
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
              margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
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
                Stack(
                  children: [
                    Card(
                      margin:
                          EdgeInsets.only(top: 75.0, right: 20.0, left: 20.0),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 65.0, bottom: 10.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "SEARCH DOCTORS",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                MyStrings.SEARCH_DOCTOR_DESCRIPTION,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: FutureBuilder<AllSpecialResponse>(
                                  future: Provider.of<DoctorSpecialtyProvider>(context, listen: false).fetchDoctorSpecialty(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return Text(
                                          'Fetch Doctor Specialty',
                                          textAlign: TextAlign.center,
                                        );
                                      case ConnectionState.active:
                                        return Text('');
                                      case ConnectionState.waiting:
                                        return Commons.otpLoading("Loading Doctor Specialties");
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          return Error(
                                            errorMessage: "Error getting Doctor Specialty.",
                                          );
                                        } else {
                                          specialtyResponse = snapshot.data;
                                          print(snapshot.data);
                                          specList = specialtyResponse.spec;
                                          return GridView.count(
                                            crossAxisCount: 2,
                                            shrinkWrap: true,
                                            childAspectRatio: 16 / 8,
                                            crossAxisSpacing: 2.0,
                                            children: specList.map((value) {
                                              return Container(
                                                child: dashBoardItem(value.name, specList.indexOf(value, 0)),
                                              );
                                            }).toList(),
                                          );
                                        }
                                    }
                                    return Commons.chuckyLoading("Getting Chucky Joke...");
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                          height: 100.0,
                          width: 100.0,
                          margin: EdgeInsets.only(top: 30.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: MyColors.primaryColor.withOpacity(0.3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/doctor.svg",
                                width: 50.0,
                                height: 50.0,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget dashBoardItem(String name, int cardIndex) {
    return InkWell(
      onTap: () {

        print("our index is $cardIndex");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SingleDoctorType(title: name)));
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: MyColors.primaryColor,
          elevation: 4.0,
          child: Container(
            height: 50.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: name.length > 12 ? 12.0 : 14.0),
                  ),
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
