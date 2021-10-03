import 'package:flutter/material.dart';
import 'package:game/game/game.dart';
import 'package:game/game/setting.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const pad = SizedBox(height: 20);
    var buttonStyle = ElevatedButton.styleFrom(fixedSize: Size(200, 20));
    return Builder(builder: (BuildContext context) {
      return Column(
        children: [
          pad,
          ElevatedButton(
              style: buttonStyle,
              child: Text("Start Game"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Game();
                }),
              )),
          pad,
          ElevatedButton(
              style: buttonStyle,
              child: Text("Settings"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Settings();
                }),
              ))
        ],
      );
    });
  }
}