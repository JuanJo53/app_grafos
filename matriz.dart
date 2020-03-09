import 'package:app_grafos/Actividad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'nodo.dart';

class matriz extends StatefulWidget{
  List<Actividad> actividades;
  List<Nodo> nodos;
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _matriz(actividades,nodos);
  }
  matriz(this.actividades,this.nodos);
}
class _matriz extends State<matriz>{
  List<Actividad> actividades;
  List<Nodo> nodos;
  List<String> texts;

  _matriz(this.actividades,this.nodos);

  @override
  Widget build(BuildContext context) {
  texts=List<String>();
  texts.add("");
  for(Nodo nodo in nodos){
    texts.add(nodo.text);
  }
  Size size=MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      
      backgroundColor: Colors.white,
      body:Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Container(
          height: (nodos.length+1.4)*50,

            child: HorizontalDataTable(
            leftSideItemBuilder: firstcolumn_builder,
            rightSideItemBuilder: data_builder,
            isFixedHeader: true,
            
            headerWidgets: texts.map((text){
              return Container(
                child: Text(text),
                width: size.width/(nodos.length+1), 
                height: 50,
                alignment: Alignment.center,
                color: Color(0xff95989B),
              );
            }).toList(), 
            leftHandSideColumnWidth: size.width/(nodos.length+1), 
            rightHandSideColumnWidth: size.width-(size.width/(nodos.length+1)), 
            itemCount: nodos.length,
          )
        ),
      ),    
    );
  }

  Widget firstcolumn_builder(BuildContext context,int index){
    Size size=MediaQuery.of(context).size;
    return Container(
      child: Text(nodos.elementAt(index).text),
      width: size.width/(nodos.length+1), 
      height: 50,
      color: Color(0xff95989B),
      alignment: Alignment.center,
    );
  }
  Widget data_builder(BuildContext context,int index){
    Size size=MediaQuery.of(context).size;
    return Row(
      children: nodos.map((nodo){
          double init=0;
          for(Actividad act in actividades){
            if(nodos.elementAt(index) == act.nodo1 && nodo == act.nodo2){
              init=double.parse(act.value);
            }
          }
          var container = Container(
            child: Text(init.toString()),
            width: size.width/(nodos.length+1), 
            height: 50,
            alignment: Alignment.center,
            color: Color(0xff5DA5EC),
          );
          return container;
      }).toList(),
    );
  }
}