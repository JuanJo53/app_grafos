import 'dart:ui';
import 'package:app_grafos/matriz.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_grafos/Actividad.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:app_grafos/nodo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Grafo extends Game {
  
  Rect posMenu;
  Offset posbtnLimpiar,posbtnGrafos,posbtnActi,posbtnMat,posbtnDelAct;
  Paint paintMenu,paintbtnLimpiar,paintbtnGrafos,paintbtnActi,paintbtnMat,paintDelAct;
  TextPainter textPaintLimp,textPaintAct,textPaintGraf,textPaintMat,textPaintDelAct;
  TextSpan textSpLimp;
  Size screenSize;
  BuildContext context;
  double tileSize;
  List<Nodo> nodos;
  List<Nodo> nodosSelec;
  List<Nodo> nodosSelec2;
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
    nodosSelec2=List<Nodo>();
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
    canvas.drawCircle(posbtnDelAct, 17,paintDelAct);
    textPaintDelAct.paint(canvas,new Offset(167, 598));
    canvas.drawCircle(posbtnMat, 17,paintbtnMat);
    textPaintMat.paint(canvas,new Offset(217, 598));
  }

  void dibujarbotones(){
    var icon2=Icons.add_circle;
    var icon4=Icons.arrow_forward;
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
    
    posbtnDelAct= Offset(180, 610);     
    paintDelAct=new Paint();
    paintDelAct.color=Color(0xff0677F0);

    textSpLimp=new TextSpan(text: icon4t,style: TextStyle(color: Colors.greenAccent,fontSize: this.tileSize/2,fontFamily: icon4.fontFamily));
    textPaintDelAct=new TextPainter(text:textSpLimp,textAlign:TextAlign.center,textDirection:TextDirection.rtl);
    textPaintDelAct.layout(); 

    posbtnMat = Offset(230, 610);     
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
              for (int i=0;i<actividad.length;i++){
                print(actividad.elementAt(i).value);
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
  bool add=true,del_nodo=false,del_act=false;
  void onTapDown(TapDownDetails d) {
    print("ADD "+add.toString()+"\nDEL NODO"+del_nodo.toString()+"\nDEL ACT"+del_act.toString());
    bool verf=false;   
    Nodo nodo_aux,nodo_selc1,nodo_selc2;
    Actividad act_aux;
    print(d.globalPosition.dx);
    print(d.globalPosition.dy);
    if(!blockScreen){ 
      if(nodos.length<15){
        for(Nodo nodo in nodos){
          if(nodo.pos.contains(d.globalPosition)&&nodosSelec.length<2&&add==true&&del_nodo==false&&del_act==false){
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
            if(nodo.pos.contains(d.globalPosition)&&add==false&&del_nodo==true&&del_act==false){
              nodo_aux=nodo;
              nodos.remove(nodo_aux);
              for(Actividad act in actividad){
                    if((nodo==act.nodo1||nodo==act.nodo2)){
                      act_aux=act;
                      actividad.remove(act_aux);
                      break;                    
                    } 
                  } 
              break;                    
            }else{
              verf=false;              
              for(Actividad act in actividad){
                if(act.atributo.contains(d.globalPosition)&&add==false&&del_nodo==false&&del_act==true){
                  act_aux=act;
                  actividad.remove(act_aux);
                  break;
                }
              }
            }              
          }     
        }
        if(!verf){
          if(d.globalPosition.dy<580&&add==true&&del_nodo==false){
            createNodoDialog(d.globalPosition.dx, d.globalPosition.dy);
          }else if(d.globalPosition.dy>595 && d.globalPosition.dx<45 && d.globalPosition.dx>15){
            nodos.clear();            
            actividad.clear();   
            Fluttertoast.showToast(
                msg: "SE LIMPIO LA PANTALLA",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );         
          }else if(d.globalPosition.dy>595 && d.globalPosition.dx<96 && d.globalPosition.dx>62){
            if(add){
              add=false;
              Fluttertoast.showToast(
                msg: "EDICION DESACTIVADO",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }else{
              add=true;
              del_nodo=false;
              del_act=false;              
              Fluttertoast.showToast(
                msg: "EDICION ACTIVADO",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
          }else if(d.globalPosition.dy>595 && d.globalPosition.dx<145 && d.globalPosition.dx>113){
            if(del_nodo){
              del_nodo=false;
              del_act=false;
              add=true;
              Fluttertoast.showToast(
                msg: "BORRAR NODO DESACTIVADO",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }else{
              add=false;
              del_nodo=true;
              del_act=false;
              Fluttertoast.showToast(
                msg: "BORRAR NODO ACTIVADO",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 16.0
              );              
            }
          }else if(d.globalPosition.dy>595 && d.globalPosition.dx<195 && d.globalPosition.dx>162){
            if(del_act){
              del_act=false;
              Fluttertoast.showToast(
                msg: "BORRAR ACTIVIDADES DESACTIVADO",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }else{
              add=false;
              del_nodo=false;
              del_act=true;              
              Fluttertoast.showToast(
                msg: "BORRAR ACTIVIDADES ACTIVADO",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
          }else if(d.globalPosition.dy>595 && d.globalPosition.dx<245  && d.globalPosition.dx>215){
            verf=true;
            add=false;
            del_nodo=false;
            del_act=false;
            if(!add && actividad.length>0){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>matriz(actividad,nodos)));
              Fluttertoast.showToast(
                msg: "MATRIZ GENERADA",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }else{
              Fluttertoast.showToast(
                msg: "DEBE TENER MINIMO UNA ACTIVIDAD",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
          }
          nodosSelec.clear();
          c++;
        }
      }       
    } 
  } 

  void trackNodoPos(){

  }

}