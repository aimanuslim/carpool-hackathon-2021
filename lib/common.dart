import 'dart:ffi';
import 'dart:math';

import 'package:carpool/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chart_components/bar_chart_component.dart';
import 'package:group_button/group_button.dart';

class MessageListPage extends StatefulWidget {
  @override
  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Messages"),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text("Message from Jans"),
              subtitle:
                  Text("Hey I would like to join you on this following days.."),
            ),
            ListTile(
              title: Text("Message from Marie"),
              subtitle:
                  Text("Hey I would like to join you on this following days.."),
            )
          ],
        ));
  }
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<UserInfo>(
          builder: (context, userinfo, child) => ListView(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<UserInfo>(
                    builder: (context, userinfo, child) => Text(
                        userinfo.isPassenger ? "Your relevant driver(s) will be notified." : "You will be notified of any interested passengers." )),
              )),
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 200,
              ),
            ],
          ),
        ));
  }
}

class ConfirmationPage extends StatefulWidget {
  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/mainpage");
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.home,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: Consumer<UserInfo>(
          builder: (context, userinfo, child) => ListView(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("You are all set!"),
              )),
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 200,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Please review your details below."),
                ),
              ),
              // userinfo.isDriver
              //     ? ListTile(
              //         title: Text("Your preferred driving days:"),
              //       )
              //     : Container(),
              // userinfo.isDriver
              //     ? Column(
              //         children: ["Monday", "Tuesday"]
              //             .map((day) => Padding(
              //                   padding: const EdgeInsets.only(left: 26.0),
              //                   child: ListTile(
              //                     leading: Icon(
              //                       Icons.check,
              //                       color: Colors.white,
              //                       size: 24,
              //                     ),
              //                     title: Text(day),
              //                   ),
              //                 ))
              //             .toList(),
              //       )
              //     : Container(),
              ListTile(
                title: Text("You Ørsted office:"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  title: Text("Hanoi"),
                ),
              ),
              userinfo.isDriver
                  ? ListTile(
                      title: Text("Number of passengers you can take:"),
                    )
                  : Container(),
              userinfo.isDriver
                  ? Padding(
                      padding: const EdgeInsets.only(left: 26.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 24,
                        ),
                        title: Text("3"),
                      ),
                    )
                  : Container(),
              ListTile(
                title: Text("Your home address"),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      userinfo.isDriver ? 
                      userinfo.driverAddress + ", " +  userinfo.driverCity + ", " + userinfo.driverPoscode :
                      userinfo.passengerAddress + ", " +  userinfo.passengerCity + ", " + userinfo.passengerPoscode
                      ),
                ),
              )
            ],
          ),
        ));
  }
}

class EnterDetailsPage extends StatefulWidget {
  @override
  _EnterDetailsPageState createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Details"),
      ),
      body: DetailsForm(),
    );
  }
}

class DetailsForm extends StatefulWidget {
  @override
  DetailsFormState createState() {
    return DetailsFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class DetailsFormState extends State<DetailsForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Address"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "City"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Postcode"),
            ),
          ),
          Consumer<UserInfo>(
            builder: (context, userinfo, child) => userinfo.isDriver
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: "No of Passengers"),
                      // TODO: form validation, number only.
                    ),
                  )
                : Container(),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text("You will shortly receive a confirmation email"),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/confirmation');
                    },
                    child: Text("Save")),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MetricsPage extends StatefulWidget {
  @override
  _MetricsPageState createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  List<double> data = List.generate(15, (index) => Random().nextDouble());
  List<String> labels = List.generate(15, (index) => (index + 2021).toString());
  int currentIndex = 1;
  List<String> allSubject = ["You", "Orsted"];
  List<String> selectedSubject = ["You"];

  void _generateLabels(int index) {
    Random rng = Random();

    if (index == 0) {
      int randomStartWeek = rng.nextInt(50);
      setState(() {
        labels = List<String>.generate(
            10, (index) => (index + randomStartWeek).toString());
      });
    }

    if (index == 1) {
      setState(() {
        labels = List<String>.generate(10, (index) => (index + 2).toString());
      });
    }

    if (index == 2) {
      int randomStartYear = 2000 + rng.nextInt(20);
      setState(() {
        labels = List<String>.generate(
            10, (index) => (index + randomStartYear).toString());
      });
    }
  }

  void _generateData(int index) {
    Random rng = Random();
    data =
        List<double>.generate(10, (index) => rng.nextDouble() + rng.nextInt(5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your performance'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                'Co2 Savings',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(
              height: 8,
            ),

            Expanded(
              flex: 30,
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: BarChart(
                  data: data,
                  labels: labels,
                  labelStyle: TextStyle(fontSize: 12),
                  valueStyle: TextStyle(fontSize: 8),
                  displayValue: true,
                  reverse: true,
                  getColor: (val) => Colors.white,
                  // getIcon: (val) => Icon(Icons.ac_unit),
                  barWidth: 30,
                  barSeparation: 40,
                  animationDuration: Duration(milliseconds: 1000),
                  animationCurve: Curves.easeInOutSine,
                  itemRadius: 10,
                  iconHeight: 24,
                  footerHeight: 24,
                  headerValueHeight: 16,
                  roundValuesOnText: false,
                  lineGridColor: Colors.lightBlue,
                ),
              ),
            ),
            // FractionallySizedBox(
            //   widthFactor: 0.9,
            //   child: ElevatedButton(
            //     child: Text(
            //       'Refresh data',
            //       style: TextStyle(color: Colors.white, fontSize: 18),
            //     ),
            //     onPressed: _loadData,
            //   ),
            // ),
            SizedBox(
              height: 8,
            ),
            GroupButton(
              isRadio: true,
              spacing: 10,
              selectedButtons: ["Week"],
              selectedColor: Color(0xff644C76),
              onSelected: (index, isSelected) {
                setState(() {
                  currentIndex = index;
                });
                _generateLabels(index);
                _generateData(index);
              },
              buttons: ["Week", "Month", "Year"],
            ),
            Expanded(
              flex: 10,
              child: Row(
                  children: allSubject
                      .map((subject) => Expanded(
                            child: ListTile(
                              leading: Checkbox(
                                value: selectedSubject.contains(subject),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      selectedSubject.add(subject);
                                    } else {
                                      selectedSubject.remove(subject);
                                    }
                                    if(selectedSubject.isEmpty) {
                                      selectedSubject.add("You");
                                    }
                                  });

                                  _generateLabels(currentIndex);
                                  _generateData(currentIndex);
                                },
                              ),
                              title: Text(subject),
                            ),
                          ))
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}
