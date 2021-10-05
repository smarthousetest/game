import 'dart:async';
import 'dart:math';

//import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/game/bomb.dart';

import 'ButtonsPainter.dart';

class Game extends StatefulWidget {
  @override
  State createState() {
    return _GameState();
  }
}

class _GameState extends State<Game> {
  var rnd1 = Random();
  var rk = Random();
  var size = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size;
  double? separatorLine;
  // bool gameIsGoing = true;
  List<Bomb> list = [];
  bool boom = false;
  bool vision = false;
  Timer ?timer;
  //var point;
  _GameState() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {generation(); });
  }
  generation(){
    var r = rnd1.nextInt(4);
    if (r == 0) {
      //нижняя часть экрана
      var x = (size.width) * rk.nextDouble();
      var y = size.height - 50;
      if (x<size.width/2){
        r=4;
      }
     spawnBomb(x,y,r);
    }
    if (r == 1) {
      //левая часть экрана
      var x = 0;
      var y = (size.height) * rk.nextDouble();
      if (y < size.height/2){
        r=5;
      }
      spawnBomb(x,y,r);
    }
    if (r == 2) {
      //верхняя часть экрана
      var x = (size.width) * rk.nextDouble();
      var y = 0;
       if (x<size.width){
         r=6;
       }
      spawnBomb(x,y,r);
    }
    if (r == 3) {
      //правая часть экрана
      var x = size.width - 50;
      var y = (size.height) * rk.nextDouble();
      if(y<size.height/2){
        r=7;
      }
      spawnBomb(x,y,r);
    }
  }
  bombExplodes(Bomb bomb, double y){
    setState(() {
      list.remove(bomb);
      if (y < this.separatorLine!){
        this.separatorLine = separatorLine! + 50;
      }
      if (y > this.separatorLine!){
        separatorLine = separatorLine! - 50;
      }
    });
  }

  spawnBomb(x,y,point) {
    setState(() {
      list.add(Bomb(x: x, y: y,point: point,bombExplodes: bombExplodes));
    });
  }

  // setPositioned(){
  //   var
  //   spawnBomb(x, y)
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var fullSize = MediaQuery.of(context).size;

    if (this.separatorLine == null) {
      this.separatorLine = fullSize.height / 2;
    }

    List<Widget> children = [
      GestureDetector(
        onTapDown: _onUserClickFunction(context),
        child: Container(
          width: fullSize.width,
          height: fullSize.height,
          child: CustomPaint(
            painter: ButtonsPainter(this.separatorLine),
          )
        )
      )
    ];
    for (var i = 0; i < list.length; i++) {
      children.add(list[i]);
    }
    return Builder(builder: (BuildContext context) {
      return Container(
          width: fullSize.width,
          height: fullSize.height,
          child: Stack(children: children));
    });
  }

  _onUserClickFunction(BuildContext context) {
    return (TapDownDetails details) => {
          this.setState(() {
            const userClickDy = 10;
            if (details.localPosition.dy < this.separatorLine!) {
              this.separatorLine = this.separatorLine! + userClickDy;
            } else if (details.localPosition.dy > this.separatorLine!) {
              this.separatorLine = this.separatorLine! - userClickDy;
            }

            if (this.separatorLine! <= 0) {

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _gameEndAlertDialog(context, "Red");
                  }).then((value) => Navigator.pop(context));
            } else if (this.separatorLine! >=
                MediaQuery.of(context).size.height) {

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return _gameEndAlertDialog(context, "Green");
                  }).then((value) => Navigator.pop(context));
            }
          })
        };
  }

  _gameEndAlertDialog(BuildContext context, String winnerColor) {
    return AlertDialog(
      title: Text("Game End"),
      content: Text("$winnerColor User Wins"),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
