import 'package:ezrecorder/provider/recorderProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print('Recorder Build');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> RecordProvider(),),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ezRecorder',
        home: HomePage(),
      ),
    );
  }
}
