import 'package:doctalk/models/booking.dart';
import 'package:doctalk/models/doctors.dart';
import 'package:doctalk/providers/BookingsProvider.dart';
import 'package:doctalk/utils/colors.dart';
import 'package:doctalk/utils/commons.dart';
import 'package:doctalk/utils/custom_loader_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:doctalk/models/bookings_response.dart';
import 'package:doctalk/view/error_fetch.dart';

extension StringExtension on String {
  String capitalizer() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class BookDoctor extends StatefulWidget {
  final Doctors doctor;

  BookDoctor({this.doctor});

  @override
  _BookDoctorState createState() => _BookDoctorState();
}

class _BookDoctorState extends State<BookDoctor>
    with SingleTickerProviderStateMixin {
  BookingsResponse _bookingsResponse;
  List<Booking> bookingsList;
  bool isButtonSelected = false;
  List<String> selectedChoices = List();
  List<String> weeksDays = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday"
  ];
  CustomLoader _loader;

  @override
  void initState() {
    super.initState();
    selectedChoices.clear();
    isButtonSelected = false;
    _loader = CustomLoader(context);

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
              height: MediaQuery.of(context).size.height * 33 / 100,
              color: MyColors.primaryColor,
              child: Column(
                children: [
                  Expanded(
                      flex: 22,
                      child: Column(
                        children: [
                          Text(
                            "${widget.doctor.firstname} ${widget.doctor.lastname}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          Text(
                            widget.doctor.specialty,
                            style: TextStyle(
                                color: Colors.grey[300], fontSize: 15.0),
                          ),
                        ],
                      )),
                  ProfileImage(context),
                  Expanded(
                    flex: 20,
                    child: Padding(
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
                              Text("3 Years exp.",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              Text("34 likes",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          SizedBox(
            height: 5.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: 12.0,
                    ),
                  ]),
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 38 / 100,
            child: ListView(
              padding: EdgeInsets.only(left: 16.0),
              children: <Widget>[
                Container(
                  child: FutureBuilder<BookingsResponse>(
                    future:
                        Provider.of<BookingsProvider>(context, listen: false)
                            .getAvailableBookings("1"),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text(
                            'Fetch Doctor Appointments',
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Commons.otpLoading(
                              "Loading Appointments for Dr. ${widget.doctor.firstname}");
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Error(
                              errorMessage: "Error getting Doctor Specialty.",
                            );
                          } else {
                            this._bookingsResponse = snapshot.data;
                            print(snapshot.data);
                            bookingsList = _bookingsResponse.booking;

                            print(selectedChoices.length > 0
                                ? selectedChoices[0]
                                : "nothing selected");

                            return Appointments(weeksDays, bookingsList, this);
                          }
                      }
                      return Commons.chuckyLoading("Getting Appointments...");
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 8 / 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (isButtonSelected) {
                      _loader.showLoader();
                      // final newUser = Provider.of<BookingsProvider>(context, listen: false)
                      //     .setBooking("lskjdflksjdfs", );

                      print(
                          "So you want to book Dr. ${widget.doctor.firstname}");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                        color: isButtonSelected
                            ? MyColors.primaryColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Center(
                        child: Text(
                      "Book Appointment",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded ProfileImage(BuildContext context) {
    return Expanded(
      flex: 60,
      child: Container(
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
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(60),
                                color: Colors.transparent),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${Commons.imageBaseURL}${widget.doctor.photo}"),
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
    );
  }
}

class ClinicInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        clinicInfoItems(Icons.phone, "+2348160161241"),
        Divider(
          color: Colors.grey,
          height: 5,
          thickness: 0.3,
          indent: 10,
          endIndent: 10,
        ),
        clinicInfoItems(
            Icons.location_on, "24 I.T Igbani Street, Jabi, Abuja, Nigeria"),
      ],
    );
  }

  Padding clinicInfoItems(IconData itemIcon, String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.0,
          ),
          Icon(
            itemIcon,
            color: Colors.grey[700],
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            item,
            style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

class FeedBackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "19 days ago",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14.0),
                  ),
                  Text(
                    "Verified User - 1",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  Text(
                    "I'm very impressed with his service",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "19 days ago",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    "Verified User - 1",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    "I'm very impressed with his service",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Appointments extends StatefulWidget {
  List<Booking> bookingsList;
  List<String> weekdays;
  _BookDoctorState parent;

  Appointments(this.weekdays, this.bookingsList, this.parent);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<String> selectionChoice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.weekdays
          .map((weekday) => WeekAppointmentsView(
              weekday: weekday,
              bookingsList: widget.bookingsList,
              parent: this.widget.parent))
          .toList(),
    );
  }
}

class WeekAppointmentsView extends StatefulWidget {
  List<Booking> bookingsList;
  String weekday;
  _BookDoctorState parent;

  WeekAppointmentsView({Key key, this.bookingsList, this.weekday, this.parent});

  @override
  _WeekAppointmentsViewState createState() => _WeekAppointmentsViewState();
}

class _WeekAppointmentsViewState extends State<WeekAppointmentsView> {
  @override
  Widget build(BuildContext context) {
    print("our current weekday is ${widget.weekday}");

    return Column(children: [
      Text(
        widget.weekday.capitalizer(),
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Wrap(
        children: widget.bookingsList
            .where((element) => element.day == widget.weekday.toLowerCase())
            .map((booking) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ChoiceChip(
                    selected:
                        this.widget.parent.selectedChoices.contains(booking.id),
                    label: Text("${booking.start} - ${booking.end}"),
                    onSelected: (bool selected) {
                      this.widget.parent.setState(() {
                        this.widget.parent.isButtonSelected = true;
                        this.widget.parent.selectedChoices.clear();
                        this.widget.parent.selectedChoices.add(booking.id);
                        print(this.widget.parent.selectedChoices);
                      });
                    },
                  ),
            ))
            .toList(),
      ),
      SizedBox(
        height: 20.0,
      )
    ]);
  }
}
