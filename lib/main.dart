import 'package:carpool/signin.dart';
import 'package:carpool/signup.dart';
import 'package:flutter/material.dart';

import 'signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carpool',
      theme: ThemeData(
        fontFamily: 'OrstedSansOffice',
        brightness: Brightness.light,
        primaryColor: Color(0xff4099DA),
        accentColor: Color(0xff644C76),
        backgroundColor: Color(0xff4099DA),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: LandingPage(title: 'Sign Up'),
      initialRoute: '/',
      // AIMMU: add routes here for the different screens. reference: https://flutter.dev/docs/cookbook/navigation/named-routes
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/signup': (context) => SignUpPage(title: "Sign Up"),
        '/signin': (context) => SignInPage(),
        '/': (context) => LandingPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/drivingto': (context) => DrivingToPage(),
        '/enterdetails': (context) => EnterDetailsPage(),
        '/commutedetails': (context) => UserCommuteDetailsPage()
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(child: Text("Sign In"),onPressed: () {
            Navigator.pushNamed(context, "/signin");
          },),
          OutlinedButton(child: Text("Sign Up"),onPressed: () {
            Navigator.pushNamed(context, "/signup");
          },),
        ],),)
      
    );
  }
}
