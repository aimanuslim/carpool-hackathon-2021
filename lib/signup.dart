import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

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
          child: OutlinedButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.pushNamed(context, '/enterdetails');
              }),
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
