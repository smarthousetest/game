
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Center(child: Text("Settings"))
      );
    });
  }
}