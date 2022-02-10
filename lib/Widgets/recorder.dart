import 'dart:html';

import 'package:ezrecorder/provider/recorderProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:microphone/microphone.dart';
import 'package:provider/provider.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

const _clientId =
    "1043182525029-6raml9bjivjpd4skfhlpnk9l39kj30qg.apps.googleusercontent.com";
const _clientSecret = "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";
const _scopes = [ga.DriveApi.driveFileScope];

enum AudioState { play, recording, pause, resume, stop }

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  // final recorder = SoundRecorder();
  AudioState? audioState;
  MicrophoneRecorder? _recorder;
  AudioPlayer? _audioPlayer;
  // GoogleDrive? driver;

  @override
  void initState() {
    super.initState();
    _recorder = MicrophoneRecorder()..init();
    // recorder.init();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // void handleAudioState(AudioState state) {
  //   setState(() {
  //     if (audioState == null) {
  //       ///Start Recording
  //       audioState = AudioState.play;
  //
  //       ///Finished Recording
  //     } else if (audioState == AudioState.recording) {
  //       audioState = AudioState.play;
  //
  //       ///Pause recording audio
  //     } else if (audioState == AudioState.pause) {
  //       audioState = AudioState.resume;
  //
  //       ///Resume recording audio
  //     } else if (audioState == AudioState.resume) {
  //       audioState = AudioState.recording;
  //
  //       ///Stop recording audio
  //     } else if (audioState == AudioState.stop) {
  //       audioState = AudioState.play;
  //     }
  //   });
  // }

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
                              borderRadius: BorderRadius.circular(30)),

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
                                      var audioLength = bytes?.length;
                                      print(audioLength);

                                      // final File fileToUpload =
                                      //     bytes as File;
                                      // print(fileToUpload);

                                      // getHttpClient();
                                      upload(bytes, audioLength);

                                      //
                                      // final fileToUpload =
                                      // _recorder!.value.recording;
                                      // print(fileToUpload);
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

                                      final bytes = await _recorder?.toBytes();
                                      var audioLength = bytes?.length;
                                      print(audioLength);

                                      var url = Url.createObjectUrlFromBlob(Blob([bytes]));
                                      AnchorElement(href: url)
                                        ..setAttribute('download', '<Audio.mp3>')
                                        ..click();


                                    // var url=" _recorder!.value.recording!.url";
                                    //   html.AnchorElement anchorElement =
                                    //   html.AnchorElement(href:url);
                                    //   anchorElement.download =
                                    //    url;
                                    //   anchorElement.click();


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

  //Get Authenticated Http Client
  Future<http.Client> getHttpClient() async {
    print('eeeee');
    var authClient = await clientViaUserConsent(
        ClientId(_clientId, _clientSecret), _scopes, (url) {
      //open an external Browser
      launch(url);
    });
    return authClient;
  }

  Future upload(file, length) async {
    print("eeeeee");
    final Stream<List> mediaStream =
        Future.value([file]).asStream().asBroadcastStream();
    var client = await getHttpClient();
    print(client);
    var drive = ga.DriveApi(client);
    var driveFile = ga.File();
    driveFile.name = "MyAudio.txt";
    var response = await drive.files
        .create(driveFile, uploadMedia: ga.Media(file, length));
    print(response.toJson());
  }
}
