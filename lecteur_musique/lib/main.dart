import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'music.dart';
import "package:audioplayer/audioplayer.dart";

//------Enumation
enum ActionMusic {play, pause, rewind, forward}
enum PlayerState {playing,stopped,paused}


void main () => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BimBamBoom Music",
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}
class HomePage extends StatefulWidget{

  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> {

  //----VARIABLES
  List<Music> listOfMusic = [
    Music("Bim Bam toi", "Carla", "images/img1.jpg",
        "https://youtu.be/pjJ2w1FX_Wg"),
    Music("Cabeza", "OBOY", "imagePath", "https://youtu.be/lEfkziQSmZI"),
  ];
  Music currentlyMusic;
  AudioPlayer audioPlayer;
  StreamSubscription positionSub;
  StreamSubscription stateSub;

  Duration position = Duration(seconds: 0);
  Duration duration = Duration(seconds: 10);
  PlayerState statut =PlayerState.stopped;


  @override initState() {
    super.initState();
    currentlyMusic = listOfMusic[0];
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("BimBamBoom Music"),
        //widget.title
        centerTitle: true,
        leading: Icon(Icons.music_note),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          color: Colors.black54,
          height: _height,
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                elevation: 18.0,
                child: Container(
                  //height: _height/3,
                  width: _height / 3,
                  child: Image.asset(listOfMusic[0].imagePath),
                ),
              ),
              myTextWithStyle(listOfMusic[0].title, 1.4),
              myTextWithStyle(listOfMusic[0].artist, 1.1),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  iconButton(Icons.fast_rewind, 30.0, ActionMusic.rewind),
                  iconButton(Icons.play_arrow, 45.0, ActionMusic.play),
                  iconButton(Icons.fast_forward, 30.0, ActionMusic.forward),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  myTextWithStyle('0:0', 0.8),
                  myTextWithStyle('0:22', 0.8),
                ],
              ),

              new Slider(
                value: position.inSeconds.toDouble(),
                max: 100,
                //longueur de morceau
                min: 0,
                activeColor: Colors.red,
                inactiveColor: Colors.blueAccent,
                //onChanged: pour mettre à jour la position de lecture du morceau de musique
                onChanged: (double d) {
                  setState(() {
                    Duration newDuration = Duration(seconds: d.toInt());
                    position = newDuration;
                  });
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  //------function 1
  Text myTextWithStyle(String data, double textScale) {
    return Text(
      data,
      textScaleFactor: textScale,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),
    );
  }

  // ---function 2
  IconButton iconButton(IconData newIcon, double iconSize, ActionMusic action) {
    return IconButton(
        icon: Icon(newIcon, size: iconSize, color: Colors.white,),
        onPressed: () {
          //pause, rewind, forward
          switch (action) {
            case ActionMusic.play:
              print("play");
              break;
            case ActionMusic.pause:
              print("pause");
              break;
            case ActionMusic.rewind:
              print("rewind");
              break;
            case ActionMusic.forward:
              print("forward");
              break;
          }
          //setState(() {time = time -5;});
        }
    );
  }

  //---- Function3: configuration of the audio player
  void configurationAudioPlayer() {
    audioPlayer = new AudioPlayer();
    positionSub = audioPlayer.onAudioPositionChanged.listen(
            (pos) =>
            setState(() {
              position = pos;
            })
    );
    stateSub = audioPlayer.onAudioPositionChanged.listen(
            (state) {
              if (state == AudioPlayerState.PLAYING){setState(() {  duration=audioPlayer.duration; });}
              else if (state == AudioPlayerState.STOPPED){setState(() {  statut=PlayerState.stopped; });}
            }, onError: (message){
              print("error: $message");
              setState(() {
                statut=PlayerState.stopped;
                duration=Duration(seconds: 0);
                position=Duration(seconds: 0);
              });

            }

    );
  }
}
