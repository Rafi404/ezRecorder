import 'package:flutter/cupertino.dart';

class RecordProvider with ChangeNotifier{

  bool startButtonStatus = true;
  bool pauseButtonStatus = false;
  bool resumeButtonStatus = false;
  bool stopButtonStatus = false;


///Start Recording here
  void onStartRecord(){
  startButtonStatus = false;
  pauseButtonStatus = true;
  stopButtonStatus = true;
  notifyListeners();
  }

  void onPauseRecord(){
    pauseButtonStatus = false;
    resumeButtonStatus = true;
    notifyListeners();
  }

  void onResumeRecord(){
    pauseButtonStatus = true;
    resumeButtonStatus = false;
    notifyListeners();
  }

  void onStopRecord(){
    pauseButtonStatus = false;
    startButtonStatus = true;
    resumeButtonStatus = false;
    stopButtonStatus = false;
    notifyListeners();
  }
}