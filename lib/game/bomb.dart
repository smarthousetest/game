import 'dart:async';
import 'package:flutter/cupertino.dart';

class Bomb extends StatefulWidget {
  final bool boom = false;
 final double x;
  final double y;
  final int point;
  final  bombExplodes;
  Bomb({required this.x, required this.y, required this.point, required this.bombExplodes});

  @override
  _BombState createState() => _BombState( y: y, bombExplodes: bombExplodes, x: x, point: point);
}
class _BombState extends State<Bomb> {
  //final child;
   bool boom = false;
   double x;
   double y;
   int point;
   var bombExplodes;
  var image = Image.asset('assets/images/Bomb.svg.png', width: 50, height: 50);
  var image2 = Image.asset('assets/images/boom.png', width: 50, height: 50);
   Timer ?timer;
  _BombState( {required this.x, required this.y, required this.point, required this.bombExplodes}){
     Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState((){
        switch (this.point){
          case 0:  //низ и бомба справа от центра
            this.x += -1;
            this.y += -1;
            break;
          case 1://лево и бомба выше центра
            this.x +=1;
            this.y += -1;
            break;
          case 2://верх и бомба лево
            this.x += 1;
            this.y += 1;
            break;
          case 3://право и ниже центра
            this.x += -1;
            this.y += -1;
            break;
          case 4://низ и бомба слева от центра
            this.x += 1;
            this.y += -1;
            break;
          case 5:
            this.x += 1;
            this.y += 1;
            break;
          case 6: //верх и право
            this.x += -1;
            this.y += 1;
            break;
          case 7://право и выше центра
            this.x +=-1;
                this.y +=1;

        }

      });
  }
  );
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: this.y,
        left: this.x,
        duration: Duration(milliseconds: 0),
        child: GestureDetector(
        onTap: _boomBomb,
            child: Container(child: this.boom ? image2 : image)));
  }

  _boomBomb(){
    setState(() {
      this.boom = true;
      timer?.cancel();

      Future.delayed(Duration(milliseconds: 100),(){
        this.bombExplodes(widget);
      });
      });

  }
}

