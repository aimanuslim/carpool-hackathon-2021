import 'package:carpool/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    builder: (context, userinfo, child) =>
                        Text("Your relevant ${userinfo.isDriver ? "passenger(s)" : "driver(s)"} will be notified.")),
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
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
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
