import 'package:ezrecorder/provider/recorderProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  final recorder = SoundRecorder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Start Button
          Provider.of<RecordProvider>(context, listen: true).startButtonStatus
              ? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(175, 50),
                      primary: Colors.teal,
                      onPrimary: Colors.white),
                  onPressed: () {
                    Provider.of<RecordProvider>(context, listen: false)
                        .onStartRecord();
                  },
                  icon: const Icon(Icons.mic),
                  label: const Text('Start Recording'),
                )
              :

              ///Pause Button
              Provider.of<RecordProvider>(context).pauseButtonStatus
                  ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(175, 50),
                          primary: Colors.amber,
                          onPrimary: Colors.white),
                      onPressed: () {
                        Provider.of<RecordProvider>(context, listen: false)
                            .onPauseRecord();
                      },
                      icon: const Icon(Icons.pause),
                      label: const Text('Pause Recording'),
                    )
                  : Container(),

          ///Resume Button
          Provider.of<RecordProvider>(context).resumeButtonStatus
              ? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(175, 50),
                      primary: Colors.teal,
                      onPrimary: Colors.white),
                  onPressed: () {
                    Provider.of<RecordProvider>(context, listen: false)
                        .onResumeRecord();
                  },
                  icon: const Icon(Icons.skip_next),
                  label: const Text('Resume Recording'),
                )
              : Container(),

          const SizedBox(
            width: 25,
          ),

          ///Stop Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(175, 50),
                primary: Colors.redAccent,
                onPrimary: Colors.white),
            onPressed: () {
              Provider.of<RecordProvider>(context, listen: false)
                  .onStopRecord();
            },
            icon: const Icon(Icons.stop),
            label: const Text('Stop Recording'),
          ),
        ],
      ),
    );
  }
}

class SoundRecorder {
  final pathToSaveAudio = 'Sample_audio.aac';
  FlutterSoundRecorder? _audioRecorder;

  Future _record() async {
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future _pause() async {
    await _audioRecorder!.pauseRecorder();
  }

  Future _resume() async {
    await _audioRecorder!.resumeRecorder();
  }

  Future _stop() async {
    await _audioRecorder!.stopRecorder();
  }
}
