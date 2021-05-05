import 'package:flutter/material.dart';

class DrivingToPage extends StatefulWidget {
  @override
  _DrivingToPageState createState() => _DrivingToPageState();
}

class _DrivingToPageState extends State<DrivingToPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driving To"),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
