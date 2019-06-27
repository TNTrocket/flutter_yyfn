import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route -- minePage"),
      ),
      body: RaisedButton(
        child: Text("JUMP index"),
        onPressed: () {
          Navigator.pushNamed(context, '/index');
        },
      ),
    );
  }
}
