import 'dart:convert';
import 'package:universal_html/html.dart';
import 'package:ezrecorder/provider/recorderProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:microphone/microphone.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  // final recorder = SoundRecorder();
  MicrophoneRecorder? _recorder;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    _recorder = MicrophoneRecorder()..init();
  }

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
                    _recorder?.start();

                    //Call Timer
                    Provider.of<RecordProvider>(context, listen: false)
                        .waveStatus = true;

                    print('Recording is started');
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

                        print('Recording is paused');
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
          if (Provider.of<RecordProvider>(context).stopButtonStatus)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(175, 50),
                  primary: Colors.redAccent,
                  onPrimary: Colors.white),
              onPressed: () {
                Provider.of<RecordProvider>(context, listen: false)
                    .onStopRecord();
                _recorder?.stop();
                Provider.of<RecordProvider>(context, listen: false).waveStatus =
                    false;

                print('Recording is stopped');

                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          elevation: 24.0,
                          // backgroundColor: Colors.teal.withOpacity(0.8),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),

                          title: const Text(
                            'Your Audio here | Click to play',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          content: Container(
                            height: 200,
                            width: 500,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListView(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ///Audio Pause Button
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        // minimumSize: const Size(175, 50),
                                        primary: Colors.greenAccent,
                                        onPrimary: Colors.teal,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.only(
                                            left: 28,
                                            right: 20,
                                            top: 20,
                                            bottom: 20),
                                      ),
                                      onPressed: () {
                                        print('Your record is paused');

                                        ///Pause Recorded Audio
                                        _audioPlayer?.pause();
                                      },
                                      icon: const Icon(Icons.pause),
                                      label: const Text(''),
                                    ),

                                    ///Audio Play Button
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        // minimumSize: const Size(175, 50),
                                        primary: Colors.greenAccent,
                                        onPrimary: Colors.teal,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 24,
                                            top: 24,
                                            bottom: 24),
                                      ),
                                      onPressed: () {
                                        print('Your record is playing');

                                        ///Play Recorded Audio
                                        _audioPlayer = AudioPlayer();
                                        // _audioPlayer?.setUrl != null?(_recorder?.value.recording?.url):"";
                                        _audioPlayer!
                                            .setUrl(
                                                _recorder!.value.recording!.url)
                                            .then((_) {
                                          return _audioPlayer?.play();
                                        });
                                      },
                                      icon: const Icon(Icons.play_arrow),
                                      label: const Text(''),
                                    ),

                                    ///Audio Stop Button
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        // minimumSize: const Size(175, 50),
                                        primary: Colors.greenAccent,
                                        onPrimary: Colors.teal,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.only(
                                            left: 28,
                                            right: 20,
                                            top: 20,
                                            bottom: 20),
                                      ),
                                      onPressed: () {
                                        print('Your record is stopped');

                                        ///Stop Recording Audio
                                        _audioPlayer?.stop();
                                      },
                                      icon: const Icon(Icons.stop),
                                      label: const Text(''),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 40,
                                ),

                                ///Save to drive button
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(175, 50),
                                        primary: Colors.greenAccent,
                                        onPrimary: Colors.white),
                                    onPressed: () async {
                                      ///File Saving to Drive
                                      final bytes = await _recorder?.toBytes();
                                      var audioLength =
                                          bytes?.length.toString();
                                      print(audioLength);

                                      var fileType = '.mp3';
                                      uploadFileToDrive(
                                          bytes, fileType, audioLength);
                                    },
                                    icon: const Icon(Icons.backup),
                                    label: const Text('Save to Drive')),

                                const SizedBox(
                                  height: 20,
                                ),

                                ///Download button
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(175, 50),
                                        primary: Colors.greenAccent,
                                        onPrimary: Colors.white),
                                    onPressed: () async {
                                      ///File Download
                                      //Converting to bytes
                                      final bytes = await _recorder?.toBytes();
                                      var audioLength = bytes?.length;

                                      //For downloading the file
                                      var url = Url.createObjectUrlFromBlob(
                                          Blob([bytes]));
                                      AnchorElement(href: url)
                                        ..setAttribute(
                                            'download', '<Audio.mp3>')
                                        ..click();
                                    },
                                    icon: const Icon(Icons.download),
                                    label: const Text('Download')),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _audioPlayer?.stop;
                                _recorder?.dispose();
                                _recorder = MicrophoneRecorder()..init();
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                    barrierDismissible: false);
              },
              icon: const Icon(Icons.stop),
              label: const Text('Stop Recording'),
            )
          else
            Container(),
        ],
      ),
    );
  }
}

Future<void> uploadFileToDrive(file, fileType, fileLength) async {
  print('eeee');
  var apiURL =
      'https://www.googleapis.com/upload/drive/v3/files?uploadType=media';
  http.Response response = await http.post(Uri.parse(apiURL),
      headers: {
        "Content-Type": fileType,
        "Content-Length": fileLength,
      },
      body: file);
  var data = jsonDecode(response.body);
  print("qqqqqqqqq $data");
  // resMessage = (data['message']);
}
