import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appgrafos/grafo.dart';
import 'package:appgrafos/nodo.dart';

class Actividad{
  final Grafo game;
  Paint paint,paintCircle;
  Offset loc1,loc2,locCircle;  
  TextSpan textSp;
  TextPainter textPaint;
  Offset offSetText,offsetDir;
  Actividad(this.game,Nodo nodo1, Nodo nodo2,String value){
    textSp=new TextSpan(text: value,style: TextStyle(color: Colors.black,fontSize: game.tileSize/4));
    textPaint=new TextPainter(text:textSp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaint.layout();    
    paint=new Paint();
    paint.color=Color(0xffc4710d);
    paint.strokeWidth=3;
    loc1=Offset(nodo1.circle.dx,nodo1.circle.dy);
    loc2=Offset(nodo2.circle.dx,nodo2.circle.dy);
    locCircle=Offset((nodo1.circle.dx+4*nodo2.circle.dx)/5, (nodo1.circle.dy+4*nodo2.circle.dy)/5);
    offSetText=Offset(
      (nodo1.circle.dx+nodo2.circle.dx)/2,(nodo1.circle.dy+nodo2.circle.dy)/2
    );
  }
  void render(Canvas canvas){    
    canvas.drawLine(loc1, loc2, paint);
    canvas.drawCircle(locCircle,6,paint);
    textPaint.paint(canvas,locCircle);
  }
}