import 'package:carpool/models.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isDriver = true;
  bool isPassenger = false;


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    UserInfo userInfoModel = Provider.of<UserInfo>(context, listen: false);
    userInfoModel.clearAll();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Consumer<UserInfo>(
                  builder: (context, userinfo, child) => Checkbox(
                      value: userinfo.isDriver,
                      onChanged: (newValue) {
                        if(newValue!){
                          userInfoModel.setAsDriver();
                        } else {
                          userInfoModel.unsetAsDriver();
                        }
                      }),
                ),
                Text("Driver"),
              ],
            ),
            Row(
              children: [
                Consumer<UserInfo>(
                  builder: (context, userinfo, child) => Checkbox(
                      value: userinfo.isPassenger,
                      onChanged: (newValue) {
                        if(newValue!){
                          userInfoModel.setAsPassenger();
                        } else {
                          userInfoModel.unsetAsPassenger();
                        }
                      }),
                ),
                Text("Passenger"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "User Initials"),
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
                    child: Text(
                      "Next",
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/headingto");
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LocationsListPage extends StatefulWidget {
  @override
  _LocationsListPageState createState() => _LocationsListPageState();
}

class _LocationsListPageState extends State<LocationsListPage> {
  Map<String, List<String>> locationList = {
    "Malaysia": ["Kuala Lumpur"],
    "Great Britain": [
      "London",
      "Edinburgh",
      "Barrow",
      "Grimsby - Lincolnshire"
    ],
    "Denmark": ["Gentofte", "Skærbæk", "Bellahøj"],
    "Germany": ["Hamburg", "Berlin", "Norden - Norddeich"],
    "Belgium": ["Brussels"],
    "Ireland": ["Cork"],
    "Japan": ["Tokyo"],
    "Poland": ["Warsaw"],
    "Sweden": ["Stockholm"],
    "Singapore": ["Singapore"],
    "Taiwan": ["Changhua", "Taipei", "Taichung"],
    "USA": [
      "Chicago",
      "Charlottesville",
      "New London",
      "Newark - New Jersey",
      "New York",
      "Providence",
      "Rhode Island",
      "Washington D.C." "Boston"
    ],
    "Vietnam": ["Hanoi"]
  };

  List<String> selectedLocations = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfWidgets = [];
    locationList.forEach((country, officeList) {
      listOfWidgets.add(ExpandableNotifier(
        child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(country),
            ),
            collapsed: Container(),
            expanded: Column(
                children: officeList
                    .map((office) => ListTile(
                          title: Text(office),
                          leading: Checkbox(
                            value: selectedLocations.contains(office),
                            onChanged: (value) {
                              setState(() {
                                if (value!) {
                                  selectedLocations.add(office);
                                } else {
                                  selectedLocations.remove(office);
                                }
                              });
                            },
                          ),
                        ))
                    .toList()),
            builder: (_, collapsed, expanded) {
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                ),
              );
            }),
      ));
    });


    return Scaffold(
      floatingActionButton: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/enterdetails");
          },
          child: Text("Next")),
        appBar: AppBar(
          title: Text("Office location")
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ListView(
                
                  children: listOfWidgets),
            )));
  }
}
