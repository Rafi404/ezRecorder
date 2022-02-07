import 'package:flutter/cupertino.dart';

class RecordProvider with ChangeNotifier{

  bool isRecording = false;
  bool startButtonStatus = true;
  bool pauseButtonStatus = false;
  bool resumeButtonStatus = false;

  void onStartRecord(){
  isRecording = true;
  startButtonStatus = false;
  pauseButtonStatus = true;
  print('Recording Started $isRecording');
  notifyListeners();
  }

  void onPauseRecord(){
    pauseButtonStatus = false;
    print('Recording Paused $pauseButtonStatus');
    resumeButtonStatus = true;
    print('Recording Paused $isRecording');
    notifyListeners();
  }

  void onResumeRecord(){
    pauseButtonStatus = true;
    resumeButtonStatus = false;
    print('Resume pressed');
    notifyListeners();
  }

  void onStopRecord(){
    isRecording = false;
    pauseButtonStatus = false;
    startButtonStatus = true;
    resumeButtonStatus = false;
    print('Recording Stopped$isRecording');

    notifyListeners();
  }
}