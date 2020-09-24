import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expansionpanel extends StatefulWidget {
  Expansionpaneltate createState() => Expansionpaneltate();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;

  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}

class Expansionpaneltate extends State<Expansionpanel> {
  List<NewItem> items = <NewItem>[
    NewItem(
        false,
        'Education',
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('MD - General Medicine '),
              Text('MBBS - Nephrology | more infor'),
              Text('MD - General Medicine | University of Abuja'),
              Text('MBBS - Nephrology | more infor'),
            ],
          ),
        ),
        Icon(Icons.image)),
    NewItem(
        false,
        'Education',
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('MD - General Medicine '),
              Text('MBBS - Nephrology | more infor'),
              Text('MD - General Medicine | University of Abuja'),
              Text('MBBS - Nephrology | more infor'),
            ],
          ),
        ),
        Icon(Icons.image)),
  ];

  ListView List_Criteria;

  Widget build(BuildContext context) {
    List_Criteria = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      leading: item.iconpic,
                      title: Text(
                        item.header,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ));
                },
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        ),
      ],
    );

    Scaffold scaffold = Scaffold(
      body: List_Criteria,
    );
    return scaffold;
  }
}
