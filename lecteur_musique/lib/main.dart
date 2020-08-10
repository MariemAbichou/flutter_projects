import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'music.dart';
import 'package:audioplayer/audioplayer.dart';

//------Enumation
enum ActionMusic {play, pause, rewind, forward}
enum PlayerState {playing,stopped,paused}


void main () => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Music Player",
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
    Music("Bim Bam toi", "Carla", "images/img1.jpg", "https://luan.xyz/files/audio/ambient_c_motion.mp3"),
    Music("Papaoutai", "Stromae", "images/img2.jpg", "https://luan.xyz/files/audio/nasa_on_a_mission.mp3"),
    Music("Tourner Dans Le Vide", "Indila", "images/img3.jpg", "https://youtu.be/vtNJMAyeP0s"),
    Music("On ira", "Stromae", "images/img4.jpg", "https://youtu.be/8IjWHBGzsu4"),

  ];
  Music currentlyMusic;
  AudioPlayer audioPlayer;
  StreamSubscription positionSub;
  StreamSubscription stateSub;

  Duration position = Duration(seconds: 0);
  Duration duration = Duration(seconds: 10);
  PlayerState statut =PlayerState.stopped;
  int index = 0;


  @override initState() {
    super.initState();
    currentlyMusic = listOfMusic[index];
    configurationAudioPlayer();
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
        title: Text("Smart Music Player"),
        //widget.title
        centerTitle: true,
        leading: Icon(Icons.music_note),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[800],
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
                  width: _height / 3,
                  child: Image.asset(currentlyMusic.imagePath),
                ),
              ),
              myTextWithStyle(currentlyMusic.title, 1.5),
              myTextWithStyle(currentlyMusic.artist, 1.1),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  iconButton(Icons.fast_rewind, 30.0, ActionMusic.rewind),
                  iconButton((statut==PlayerState.playing)?Icons.pause:Icons.play_arrow, 45.0, (statut == PlayerState.playing) ? ActionMusic.pause:ActionMusic.play),
                  iconButton(Icons.fast_forward, 30.0, ActionMusic.forward),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  myTextWithStyle(fromDuration(position), 0.8),
                  myTextWithStyle(fromDuration(duration), 0.8),
                ],
              ),

              new Slider(
                value: position.inSeconds.toDouble(),
                min: 0,
                max: 30,    //TO DO/ CHANGE longueur de morceau
                activeColor: Colors.red,
                inactiveColor: Colors.blueAccent,
                //onChanged: pour mettre à jour la position de lecture du morceau de musique
                onChanged: (double d) {
                  setState(() {
                    audioPlayer.seek(d);
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
              play();
              break;
            case ActionMusic.pause:
              print("pause");
              pause();
              break;
            case ActionMusic.rewind:
              print("rewind");
              rewind();
              break;
            case ActionMusic.forward:
              print("forward");
              forward();
              break;
          }
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

//---- Function4: play music
Future play() async {
    await audioPlayer.play(currentlyMusic.urlSong);
    setState(() {
      statut=PlayerState.playing;
    });
}
//---- Function5: pause music
  Future pause() async {
    await audioPlayer.pause();
    setState(() {
      statut=PlayerState.paused;
    });
  }
// --- fonction pour passer au morceau suivant
void forward(){
    if (index== listOfMusic.length-1){index=0;}
    else {index++;}
    currentlyMusic=listOfMusic[index];
    audioPlayer.stop();
    configurationAudioPlayer();
    play();
}
//---------
  void rewind() {
    if (position > Duration(seconds: 3)) {
      audioPlayer.seek(0.0);
    } else {
      if (index == 0) {
        index = listOfMusic.length - 1;
      } else {
        index--;
      }
      currentlyMusic = listOfMusic[index];
      audioPlayer.stop();
      configurationAudioPlayer();
      play();
    }
  }
  //---------
  String fromDuration(Duration duree) {
    print(duree);
    return duree.toString().split('.').first;
  }

//----fin---
}
