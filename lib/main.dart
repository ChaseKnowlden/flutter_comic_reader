import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
      name: 'comic_reader_flutter',
      options: Platform.isMacOS || Platform.isIOS
          ? FirebaseOptions(
              appId: 'IOS KEY',
              apiKey: 'AIzaSyDrtmulc4rbPHnh6n55pJvDpngo9fxfHUY',
              projectId: 'comicreader-a3f36',
              messagingSenderId: '146542806935',
              databaseURL: 'https://comicreader-a3f36.firebaseio.com')
          : FirebaseOptions(
              appId: '1:146542806935:android:e04497746ccf1f55aae6d2',
              apiKey: 'AIzaSyDrtmulc4rbPHnh6n55pJvDpngo9fxfHUY',
              projectId: 'comicreader-a3f36',
              messagingSenderId: '146542806935',
              databaseURL: 'https://comicreader-a3f36.firebaseio.com'));
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
      home: MyHomePage(
        title: 'Comic Reader',
        app: app,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.app}) : super(key: key);

  final FirebaseApp app;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference _bannerRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase _database = FirebaseDatabase(app: widget.app);
    _bannerRef = _database.reference().child('Banners');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF44A3E),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<String>>(
          future: getBanners(_bannerRef),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                      items: snapshot.data
                          .map((e) => Builder(
                                builder: (context) {
                                  return Image.network(e, fit: BoxFit.cover);
                                },
                              ))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          initialPage: 0,
                          height: MediaQuery.of(context).size.height / 3))
                ],
              );
            else if (snapshot.hasError)
              return Center(
                child: Text('${snapshot.error}'),
              );
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Future<List<String>> getBanners(DatabaseReference bannerRef) {
    return bannerRef
        .once()
        .then((snapshot) => snapshot.value.cast<String>().toList());
  }
}
