import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:app_grafos/grafo.dart';

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
    return Scaffold(
      body: game.widget!=null?game.widget:Container());
  }
  void initState() {
    Start();
  }
}