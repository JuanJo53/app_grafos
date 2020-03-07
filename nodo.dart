import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_grafos/grafo.dart';

class Nodo {
  final Grafo game;
  Size screenSize;
  Offset circle,offSetText;
  Paint paint;
  Rect pos;
  TextSpan textSp;
  TextPainter textPaint;

  Nodo(this.game,double x,double y,String text){
    textSp=new TextSpan(text: text,style: TextStyle(color: Colors.purple,fontSize: game.tileSize/2));
    textPaint=new TextPainter(text:textSp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaint.layout();
    pos=Rect.fromLTWH(x-game.tileSize/2, y-game.tileSize/2, game.tileSize, game.tileSize);
    paint=new Paint();
    paint.color=Color(0xff00A2FF);
    circle = Offset(x, y);
  }
  void render(Canvas canvas) {
    canvas.drawCircle(circle, game.tileSize/2,paint);
    double textW=textPaint.width,textH=textPaint.height;       
    offSetText=Offset(circle.dx-textW/2, circle.dy-textH/2);
    textPaint.paint(canvas,offSetText);
  }

  void selectNodo(){
    paint.color=Color(0xff00fffb);  
  }
  void unselectNodo(){
    paint.color=Color(0xff00A2FF);  
  }
  void update(double t) {
    
  }

}