import 'package:ezrecorder/Widgets/recorder.dart';
import 'package:ezrecorder/Widgets/soundWave.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/recorderProvider.dart';

Widget smGutter() {
  return const SizedBox(
    height: 30,
  );
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('ezRecorder'),
        elevation: 2.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10, right: 30),
            child: Row(
              children: const [
                Icon(Icons.mic),
                Text(
                  'My Records',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView(
            children: [
              const Text(
                "ezRecord. A Simple Audio Recorder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 45,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              smGutter(),
              smGutter(),
              const AudioRecorder(),
              smGutter(),
              smGutter(),
              Provider.of<RecordProvider>(context).waveStatus
                  ? const SoundWave()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
