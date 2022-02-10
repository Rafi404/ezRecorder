import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart ';

class SoundWave extends StatelessWidget {
  const SoundWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AudioWave(
        height: 52,
        width: 150,
        spacing: 2.5,
        bars: [
          AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
          AudioWaveBar(height: 30, color: Colors.blue),
          AudioWaveBar(height: 70, color: Colors.black),
          AudioWaveBar(height: 40),
          AudioWaveBar(height: 20, color: Colors.orange),
          AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
          AudioWaveBar(height: 30, color: Colors.blue),
          AudioWaveBar(height: 70, color: Colors.black),
          AudioWaveBar(height: 40),
          AudioWaveBar(height: 20, color: Colors.orange),
          AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
          AudioWaveBar(height: 30, color: Colors.blue),
          AudioWaveBar(height: 70, color: Colors.black),
          AudioWaveBar(height: 40),
          AudioWaveBar(height: 20, color: Colors.orange),
          AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
          AudioWaveBar(height: 30, color: Colors.blue),
          AudioWaveBar(height: 70, color: Colors.black),
          AudioWaveBar(height: 40),
          AudioWaveBar(height: 20, color: Colors.orange),
        ],
      ),
    );
  }
}
