import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer audioPlayer = AudioPlayer();
  String audioUrl = 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((event) {

    });
  }

  Future<void> playAudio() async {
    try {
      Source source = UrlSource(audioUrl);
      await audioPlayer.play(source);
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> pauseAudio() async {
    try {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Audio File',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            isPlaying
                ? ElevatedButton(
              onPressed: pauseAudio,
              child: Text('Pause'),
            )
                : ElevatedButton(
              onPressed: playAudio,
              child: Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
