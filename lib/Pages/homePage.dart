import 'package:ezrecorder/Widgets/recorder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/html.dart';
import 'package:universal_html/js.dart' as js;
import 'package:universal_html/js_util.dart' as js;

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
            children: const [
              AudioRecorder(),
            ],
          ),
        ),
      ),
    );
  }
}
