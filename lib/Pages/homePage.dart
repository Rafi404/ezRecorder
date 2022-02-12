import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ezrecorder/Widgets/recorder.dart';
import 'package:ezrecorder/Widgets/soundWave.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;
  late String appNetworkStatus;

  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Network Change Detected! \n Check Your Internet Connection';
        break;

      // case ConnectivityResult.wifi:
      //   status = 'WiFi';
      //   break;
      //
      // case ConnectivityResult.none:
      //   status = 'None';
      //   break;

      default:
        status = 'None';
        break;
    }
    return status;
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetworkConnectivity();
    super.initState();
  }

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

  //Check Network Connection
  void checkNetworkConnectivity() {
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      var conn = getConnectionValue(result);
      setState(() {
        appNetworkStatus = conn;
        showToast(appNetworkStatus);
      });
    });
  }
}

void showToast(appNetworkStatus) {
  Fluttertoast.showToast(
      msg: "$appNetworkStatus",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
