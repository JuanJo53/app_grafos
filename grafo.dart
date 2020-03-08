import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_grafos/Actividad.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:app_grafos/nodo.dart';

class Grafo extends Game {
  
  Rect posMenu;
  Offset posbtnLimpiar,posbtnGrafos,posbtnActi,posbtnMat;
  Paint paintMenu,paintbtnLimpiar,paintbtnGrafos,paintbtnActi,paintbtnMat;
  TextPainter textPaintLimp,textPaintAct,textPaintGraf,textPaintMat;
  TextSpan textSpLimp;
  Size screenSize;
  BuildContext context;
  double tileSize;
  List<Nodo> nodos;
  List<Nodo> nodosSelec;
  List<Actividad> actividad;
  int c=0;
  bool blockScreen=false;
  String nodoName="",actName="";
  Icon clean,del_act,del_nod,add_act,add_nod;
  

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
    Rect bgRect = Rect.fromLTWH(0 , 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffffffff);
    canvas.drawRect(bgRect, bgPaint);
    nodos.forEach((Nodo nodo)=>nodo.render(canvas));
    actividad.forEach((Actividad act)=>act.render(canvas));

    posMenu=Rect.fromLTWH(0, 580, 415, 60);
    paintMenu=new Paint();
    paintMenu.color=Color(0xff06F09B);

    dibujarbotones();
    
    canvas.drawRect(posMenu, paintMenu);
    canvas.drawCircle(posbtnLimpiar, 17,paintbtnLimpiar);
    textPaintLimp.paint(canvas,new Offset(17, 598));
    canvas.drawCircle(posbtnActi, 17,paintbtnActi);
    textPaintAct.paint(canvas,new Offset(67, 598));
    canvas.drawCircle(posbtnGrafos, 17,paintbtnGrafos);
    textPaintGraf.paint(canvas,new Offset(117, 598));
    canvas.drawCircle(posbtnMat, 17,paintbtnMat);
    textPaintMat.paint(canvas,new Offset(167, 598));
  }

  void dibujarbotones(){
    var icon2=Icons.add_circle;
    var icon4=Icons.keyboard_backspace;
    var icon3=Icons.remove_circle;
    var icon1=Icons.delete;
    var icon5=Icons.table_chart;
    String icon1t=String.fromCharCode(icon1.codePoint);
    String icon2t=String.fromCharCode(icon2.codePoint);
    String icon3t=String.fromCharCode(icon3.codePoint);
    String icon4t=String.fromCharCode(icon4.codePoint);
    String icon5t=String.fromCharCode(icon5.codePoint);

    posbtnLimpiar = Offset(30, 610);     
    paintbtnLimpiar=new Paint();
    paintbtnLimpiar.color=Color(0xff0677F0);

    textSpLimp=new TextSpan(text: icon1t,style: TextStyle(color: Colors.greenAccent,fontSize: this.tileSize/2,fontFamily: icon1.fontFamily));
    textPaintLimp=new TextPainter(text:textSpLimp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaintLimp.layout();    
    
    posbtnActi = Offset(80, 610);     
    paintbtnActi=new Paint();
    paintbtnActi.color=Color(0xff0677F0);

    textSpLimp=new TextSpan(text: icon2t,style: TextStyle(color: Colors.greenAccent,fontSize: this.tileSize/2,fontFamily: icon2.fontFamily));
    textPaintAct=new TextPainter(text:textSpLimp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaintAct.layout();   

    posbtnGrafos = Offset(130, 610);     
    paintbtnGrafos=new Paint();
    paintbtnGrafos.color=Color(0xff0677F0);

    textSpLimp=new TextSpan(text: icon3t,style: TextStyle(color: Colors.greenAccent,fontSize: this.tileSize/2,fontFamily: icon3.fontFamily));
    textPaintGraf=new TextPainter(text:textSpLimp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaintGraf.layout(); 

    posbtnMat = Offset(180, 610);     
    paintbtnMat=new Paint();
    paintbtnMat.color=Color(0xff0677F0);

    textSpLimp=new TextSpan(text: icon5t,style: TextStyle(color: Colors.greenAccent,fontSize: this.tileSize/2,fontFamily: icon5.fontFamily));
    textPaintMat=new TextPainter(text:textSpLimp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaintMat.layout(); 
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
              // print(nodos.);
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
              for (int i=0;i<nodos.length;i++){
                print(nodos.elementAt(i).text);
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
      if(nodos.length<15){
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
          if(d.globalPosition.dy<580){
            createNodoDialog(d.globalPosition.dx, d.globalPosition.dy);
          }          
          nodosSelec.clear();
          c++;
        }
      }       
    } 
  } 
}