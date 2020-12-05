import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'comic_reader_flutter',
    options: Platform.isMacOS || Platform.isIOS ?
        FirebaseOptions(
          appId: 'IOS KEY',
          apiKey: 'AIzaSyDrtmulc4rbPHnh6n55pJvDpngo9fxfHUY',
          projectId: 'comicreader-a3f36',
          messagingSenderId: '146542806935',
          databaseURL: 'https://comicreader-a3f36.firebaseio.com'
        )
        :
    FirebaseOptions(
        appId: '1:146542806935:android:e04497746ccf1f55aae6d2',
        apiKey: 'AIzaSyDrtmulc4rbPHnh6n55pJvDpngo9fxfHUY',
        projectId: 'comicreader-a3f36',
        messagingSenderId: '146542806935',
        databaseURL: 'https://comicreader-a3f36.firebaseio.com'
    )
  );
  runApp(ProviderScope(child: MyApp(app: app)));
}

class MyApp extends StatelessWidget {
  FirebaseApp app;
  MyApp({this.app});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}
