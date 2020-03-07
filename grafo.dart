import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_grafos/Actividad.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:app_grafos/nodo.dart';

class Grafo extends Game {
  Size screenSize;
  BuildContext context;
  double tileSize;
  List<Nodo> nodos;
  List<Nodo> nodosSelec;
  List<Actividad> actividad;
  int c=0;
  bool blockScreen=false;
  String nodoName="",actName="";
  Grafo(BuildContext context){
    this.context=context;
    initialize();
  }
  void initialize() async {
    nodos=List<Nodo>();
    nodosSelec=List<Nodo>();
    actividad=List<Actividad>();
    resize(await Flame.util.initialDimensions());
  }
  void render(Canvas canvas) {
    // draw a black background on the whole screen
    Rect bgRect = Rect.fromLTWH(0 , 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffffffff);
    canvas.drawRect(bgRect, bgPaint);
    nodos.forEach((Nodo nodo)=>nodo.render(canvas));
    actividad.forEach((Actividad act)=>act.render(canvas));
  }
  createNodoDialog(double x,double y){
    TextEditingController controller=TextEditingController();
    blockScreen=true;
    showDialog(context: context,builder: (BuildContext context){
      return WillPopScope(child: AlertDialog(
        title: Text("Nombre del Nodo:"),
        content: TextField(
          controller: controller,
          maxLength: 10,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0, 
            child: Text("Aceptar"),
            onPressed: () {
              blockScreen=false;
              nodoName=controller.text.toString();
              Navigator.pop(context);
              nodos.add(Nodo(this, x, y,nodoName));              
            },            
          ),
          MaterialButton(
            elevation:5.0, 
            child: Text("Cancelar"),
            onPressed: () {
              blockScreen=false;
              Navigator.pop(context);              
            },            
          ),
        ],
      ), 
      onWillPop: ()async{
        blockScreen=false;
        return true;
      });
    });
  }
  createActDialog(){
    TextEditingController controller=TextEditingController();
    blockScreen=true;
    showDialog(context: context,builder: (BuildContext context){
      return WillPopScope(
        onWillPop: ()async{
        blockScreen=false;
        return true;
      },
        child: AlertDialog(
        title: Text("Valor del Atributo"),
        content: TextField(
          controller: controller,
          maxLength: 10,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0, 
            child: Text("Aceptar"),
            onPressed: () {
              blockScreen=false;
              actName=controller.text.toString();
              Navigator.pop(context);
              actividad.add(Actividad(this, nodosSelec.elementAt(0),nodosSelec.elementAt(1),actName));   
              for(Nodo nodo in nodos){          
                nodo.unselectNodo();
              }    
            },            
          ),
          MaterialButton(
            elevation:5.0, 
            child: Text("Cancelar"),
            onPressed: () {
              blockScreen=false;
              Navigator.pop(context);
            },            
          ),
        ],
      ),);
    });
  }
  void update(double t) {
    
  }

  void resize(Size size) {
    screenSize = size;
    tileSize=screenSize.width/7;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    bool verf=false;   
    print(d.globalPosition.dx);
    print(d.globalPosition.dy);
    if(!blockScreen){ 
      if(nodos.length<9){
        for(Nodo nodo in nodos){
          if(nodo.pos.contains(d.globalPosition)&&nodosSelec.length<2){
            nodosSelec.add(nodo);
            nodo.selectNodo();
            if(nodosSelec.length==2){
              createActDialog();
              //nodo.unselectNodo();
            }
            verf=true;
            break;
          }else{
            verf=false;
          }     
        }
        if(!verf){
          createNodoDialog(d.globalPosition.dx, d.globalPosition.dy);
          nodosSelec.clear();
          c++;
        }
      }       
    } 
  } 
}