import 'dart:math';

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_grafos/grafo.dart';
import 'package:app_grafos/nodo.dart';

class Actividad{
  final Grafo game;
  Paint paint,paintCircle;
  Offset loc1,loc2,locCircle;  
  TextSpan textSp;
  TextPainter textPaint;
  double dx, dy;
  double tox,toy;
  Offset offSetText,offsetDir;
  String value;
  Actividad(this.game,Nodo nodo1, Nodo nodo2,this.value){
    textSp=new TextSpan(text: value,style: TextStyle(color: Colors.black,fontSize: game.tileSize/4));
    textPaint=new TextPainter(text:textSp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaint.layout();    
    paint=new Paint();
    paint.color=Color(0xff000000);
    paint.strokeWidth=3;
    
    loc1=Offset(nodo1.circle.dx,nodo1.circle.dy);
    loc2=Offset(nodo2.circle.dx,nodo2.circle.dy);
    
    // if(nodo1.circle.dy>nodo2.circle.dy){
    //   loc1=Offset(nodo1.circle.dx,nodo1.circle.dy+30);
    //   loc2=Offset(nodo2.circle.dx,nodo2.circle.dy-30);
    // }else{
    //   loc1=Offset(nodo1.circle.dx,nodo1.circle.dy+30);
    //   loc2=Offset(nodo2.circle.dx,nodo2.circle.dy-30);
    // }
    // if(nodo1.circle.dx>nodo2.circle.dx){
    //   loc1=Offset(nodo1.circle.dx-10,nodo1.circle.dy);
    //   loc2=Offset(nodo2.circle.dx,nodo2.circle.dy);
    // }else{
    //   loc1=Offset(nodo1.circle.dx,nodo1.circle.dy);
    //   loc2=Offset(nodo2.circle.dx-10,nodo2.circle.dy);
    // }

    offSetText=Offset(
      (nodo1.circle.dx+nodo2.circle.dx*3)/4,(nodo1.circle.dy+nodo2.circle.dy*3)/4
    );
    tox=nodo2.circle.dx;
    toy=nodo2.circle.dy;
    dx = (nodo2.circle.dx-nodo1.circle.dx);
    dy = (nodo2.circle.dy-nodo1.circle.dy);
  }
  void render(Canvas canvas){    
    int headlen = 10;
    
    double angle = atan2(dy,dx);

    Offset center1= Offset(tox - headlen * cos(angle +pi / 6),toy - headlen * sin(angle + pi / 6));
    Offset center2= Offset(tox - headlen * cos(angle -pi / 6),toy - headlen * sin(angle - pi / 6));
    canvas.drawLine(loc1, loc2, paint);
    canvas.drawLine(center1, loc2, paint);
    canvas.drawLine(center2, loc2, paint);
    textPaint.paint(canvas,offSetText);
    
    // Size size;
    // Path path;
    // path = Path();
    // path.moveTo(size.width * 0.25, size.height * 0.10);
    // path.relativeCubicTo(0, 0, size.width * 0.25, 50, size.width * 0.5, 0);
    // path = ArrowPath.make(path: path);
    // canvas.drawPath(path, paint..color = Colors.blue);
  }
}