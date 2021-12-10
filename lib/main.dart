// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application_1/music.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ynovify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'YNOVIFY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = true;
  int selMusic = 0;

  List<Music> myMusicList = [
    Music('Loulou la go jazz', 'Sigmund Freud', 'assets/images/lolo.jpg',
        'https://music.florian-berthier.com/Dynasties%20and%20Dystopia%20-%20Danzel%20Curry.mp3'),
    Music('shake', 'POULOU', 'assets/images/lala.webp',
        'https://music.florian-berthier.com/Guns%20for%20Hire%20-%20Woodkid.mp3')
  ];

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _init(selMusic);
  }

  Future<void> _init(int selMusic) async {
    await _player.setAudioSource(
        AudioSource.uri(Uri.parse(myMusicList[selMusic].urlSong)));
  }

  void _incrementCounter() {
    setState(() {
      (selMusic == myMusicList.length - 1) ? selMusic = 0 : selMusic++;
    });
    _init(selMusic);
  }

  void _decrementCounter() {
    setState(() {
      (selMusic == 0) ? selMusic = myMusicList.length - 1 : selMusic--;
    });
    _init(selMusic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text(widget.title, textAlign: TextAlign.center)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset(myMusicList[selMusic].imagePath),
            ),
            Text(
              myMusicList[selMusic].title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              myMusicList[selMusic].singer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: _decrementCounter,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(selected ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          selected = !selected;
                          if (selected) {
                            _player.play();
                          } else {
                            _player.pause();
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: _incrementCounter,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
