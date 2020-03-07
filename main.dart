import 'package:appgrafos/grafo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp()
    )
  );
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }

}

class _MyApp extends State<MyApp> {
  Grafo game;
  void Start()async{
    WidgetsFlutterBinding.ensureInitialized();
    
    Util flameUtil = Util();
    
    game = Grafo(context);
    
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);
    
    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = game.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //body: game.widget!=null?game.widget:Container()
      body: Stack(
        children: <Widget>[
          game.widget,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Maze Ball",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 6,
                      color: Colors.white),
                ),
                RaisedButton(
                    child: Text("Play"),
                    onPressed: () async {
                    
                    }),
                RaisedButton(
                    child: Text("Options"),
                    onPressed: () async {
                    }),
                RaisedButton(
                    child: Text("About"),
                    onPressed: () {
                      })
              ],
            ),
          ),
        ],
      ),
    );
  }
  void initState() {
    Start();
  }
  /*@override
  Widget build(BuildContext context) {
    return Scaffold()
      
  }*/
}