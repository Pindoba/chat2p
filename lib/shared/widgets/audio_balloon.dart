import 'package:flutter/material.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';

class AudioBalloon extends StatefulWidget {
  const AudioBalloon({super.key});

  @override
  State<AudioBalloon> createState() => _AudioBalloonState();
}

class _AudioBalloonState extends State<AudioBalloon> {
  Duration duration = new Duration();
  Duration position = new Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  void _seek(double num){
    
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.play_circle_fill,
              size: 52,
            )),
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Image.network(
            'https://static.vecteezy.com/system/resources/previews/022/818/351/original/sound-wave-or-voice-message-icon-music-waveform-track-radio-play-audio-equalizer-line-illustration-vector.jpg',
            fit: BoxFit.contain,
          ),
        ),
        // BubbleNormalAudio(onSeekChanged: _changeSeek, onPlayPauseButtonClick: (){})
      ],
    );
  }

  void _changeSeek(double value) {
  }
}
