import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';


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

  void _driverSelected(bool newValue) {
    setState(() {
      isDriver = newValue;
    });
  }

  void _passengerSelected(bool newValue) {
    setState(() {
      isPassenger = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                Checkbox(
                    value: isDriver,
                    onChanged: (newValue) {
                      _driverSelected(newValue!);
                    }),
                Text("Driver"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: isPassenger,
                    onChanged: (newValue) {
                      _passengerSelected(newValue!);
                    }),
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
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/drivingto");
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

class DrivingToPage extends StatefulWidget {
  @override
  _DrivingToPageState createState() => _DrivingToPageState();
}

class _DrivingToPageState extends State<DrivingToPage> {
  Map<String, List<String>> locationList = {
    "Malaysia": ["KL"],
    "UK": ["London", "EC", "H2C"]
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

    listOfWidgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Next"),
          ),
        )
      ],
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Driving To"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listOfWidgets)));
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "No of Passengers"),
              // TODO: form validation, number only.
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("You will shortly receive a confirmation email"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: OutlinedButton(
                  onPressed: (){

                  }, 
                  child: Text("Next")),
              )
            ],)
        ],
      ),
    );
  }
}
