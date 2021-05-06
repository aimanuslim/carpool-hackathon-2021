import 'package:flutter/material.dart';

class SavedKM extends StatelessWidget {
  // Declare a field that holds the Person data
  final int number;
  // In the constructor, require a Person
  SavedKM({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/mainpage");
          },
          child:
              Text(number.toString() + ' km of driving saved by doing this.'),
        ),
      ),
    );
  }
}
