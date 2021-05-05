import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/commutedetails");
                      },
                      child: Text("Next")),
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
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          OutlinedButton(child: Text("Commute details"), onPressed: () {
            Navigator.pushNamed(context, "/commutedetails");

          }),
          OutlinedButton(child: Text("User info"), onPressed: () {
            Navigator.pushNamed(context, "/");
            // TODO: to continue
            
          }),
        ],
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
    return Scaffold(
      floatingActionButton: OutlinedButton(
        child: Text("Next"),
        onPressed: () {
          Navigator.pushNamed(context, '/selecteddrivers');
        },
      ),
      appBar: AppBar(
        title: Text("Car pooling details."),
      ),
      body: ListView(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Driving days"),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Week 18"),
          )),
          Column(
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
          ),
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
          child: Text("Following drivers could help pick you up"),
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
