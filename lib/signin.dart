import 'package:carpool/models.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'google_maps.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    UserInfo userInfoModel = Provider.of<UserInfo>(context, listen: false);
    userInfoModel.clearAll();
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "User"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Code"),
              ),
            ),
            Consumer<UserInfo>(
              builder: (context, userinfo, child) => ListTile(
                leading: Checkbox(
                    onChanged: (value) {
                      if (value!) {
                        userInfoModel.setAsDriver();
                        userInfoModel.unsetAsPassenger();
                      } else {
                        userInfoModel.unsetAsDriver();
                        userInfoModel.setAsPassenger();
                      }
                    },
                    value: userinfo.isDriver),
                title: Text("Driver"),
              ),
            ),
            Consumer<UserInfo>(
              builder: (context, userinfo, child) => ListTile(
                leading: Checkbox(
                    onChanged: (value) {
                      if (value!) {
                        userInfoModel.unsetAsDriver();
                        userInfoModel.setAsPassenger();
                      } else {
                        userInfoModel.setAsDriver();
                        userInfoModel.unsetAsPassenger();
                      }
                    },
                    value: userinfo.isPassenger),
                title: Text("Passenger"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/mainpage");
                      },
                      child: Text("Login")),
                )
              ],
            )
          ],
        ));
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
        builder: (context, userinfo, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
            child: Icon(Icons.power_settings_new)),
          title: Text("Main Menu"),
          actions: [
            userinfo.isDriver ? Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/messagelist');
                  },
                  child: new Stack(
                    children: <Widget>[
                      new Icon(
                        Icons.message,
                        size: 40,
                      ),
                      new Positioned(
                        right: 0,
                        child: new Container(
                          padding: EdgeInsets.all(1),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: new Text(
                            "1",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ) : Container(),
          ],
        ),
        body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: [
                Center(
                  child: OutlinedButton(
                      child: Text("Car pooling details"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/commutedetails");
                      }),
                ),
                Center(
                  child: OutlinedButton(
                      child: Text("Edit your information"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/headingto");
                        // TODO: to continue
                      }),
                ),
                userinfo.isPassenger
                    ? Center(
                        child: OutlinedButton(
                            child: Text("Find a ride"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GoogleMaps(
                                          source_location: LatLng(
                                              3.1112913233110935,
                                              101.66584823996021),
                                          dest_location: LatLng(
                                              3.1956071385311455,
                                              101.60778900777943),
                                          passenger_location: LatLng(
                                              3.160461096819543,
                                              101.59772941034296),
                                        )),
                              );
                            }),
                      )
                    : Container(),
              ],
            ),
          ),
        
      ),
    );
  }
}

class UserCommuteDetailsPage extends StatefulWidget {
  @override
  _UserCommuteDetailsPageState createState() => _UserCommuteDetailsPageState();
}

class _UserCommuteDetailsPageState extends State<UserCommuteDetailsPage> {
  List<String> selectedDays = [];
  List<String> selectedTimes = [];

  @override
  Widget build(BuildContext context) {
    UserInfo userInfoModel = Provider.of<UserInfo>(context, listen: false);

    return Scaffold(
      floatingActionButton: OutlinedButton(
        child: Text("Next"),
        onPressed: () {
          Navigator.pushNamed(context, '/notification');
        },
      ),
      appBar: AppBar(
        title: Text("Car pooling details."),
      ),
      body: Consumer<UserInfo>(
        builder: (context, userinfo, child) => ListView(
          children: [
            userinfo.isDriver
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Driving days"),
                  ))
                : Container(),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Week 18"),
            )),
            userinfo.isDriver
                ? Column(
                    children: [
                      "All Days",
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                    ]
                        .map((day) => ListTile(
                            title: Text(day),
                            leading: Checkbox(
                              value: selectedDays.contains(day),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    selectedDays.add(day);
                                  } else {
                                    selectedDays.remove(day);
                                  }
                                });
                              },
                            )))
                        .toList(),
                  )
                : Container(),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("I would like to be in office at:"),
            )),
            Column(
              children: [
                "8:30 AM",
                "9:00 AM",
                "9:30 AM",
              ]
                  .map((day) => ListTile(
                      title: Text(day),
                      leading: Checkbox(
                        value: selectedTimes.contains(day),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedTimes.add(day);
                            } else {
                              selectedTimes.remove(day);
                            }
                          });
                        },
                      )))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedDriverPage extends StatefulWidget {
  @override
  _SelectedDriverPageState createState() => _SelectedDriverPageState();
}

class _SelectedDriverPageState extends State<SelectedDriverPage> {
  List<String> driverList = [
    "Peter Kia",
    "Andres Ford",
    "Peter Bentley",
    "Niels Obel"
  ];

  List<String> selectedDriver = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Select from these following available drivers."),
        )),
        Column(
          children: driverList
              .map((driver) => ListTile(
                  title: Text(driver),
                  leading: Checkbox(
                    value: selectedDriver.contains(driver),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          selectedDriver.add(driver);
                        } else {
                          selectedDriver.remove(driver);
                        }
                      });
                    },
                  )))
              .toList(),
        )
      ]),
    );
  }
}
