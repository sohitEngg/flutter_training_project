import 'package:bloc_training_app/presentation/person_list.dart';
import 'package:bloc_training_app/presentation/qr_scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/person_list_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  String _initMsg = "Unknow";

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: Text("Person App"),
        backgroundColor: Colors.blue,
      ),
      body: TabBarView(
        children: <Widget>[
          BlocProvider<PersonListBloc>(
            builder: (context) => PersonListBloc(),
            child: PersonListPage(),
          ),
          QrScanPage(),
          Icon(Icons.directions_bike),
        ],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.group),
            ),
            Tab(
              icon: Text('||||||'),
            ),
            Tab(
              icon: Icon(Icons.airport_shuttle),
            ),
          ],
          controller: controller,
        ),
      ),
    );
  }
}

/*
// To initialize the adobe analytics below code is required
import 'package:adobe_mobile_sdk_flutter/adobe_mobile_sdk_flutter.dart';
Future<void> initTrackState() async {
    try {
      await AdobeMobileSdkFlutter.initTrack("ADBMobileConfigCustom.json");
      setState(() {
        _initMsg = "Track is init...";
      });
    } on Exception {
      setState(() {
        _initMsg = 'Failed to init Adobe Tracking';
      });
    }
  }


// To track screen and action use below code block
String result = await AdobeAnalyticsPlugin.trackState(
        "SCREEN_NAME",
        null
    );


//This function is use for track the action with optional data.
trackAction(String actionName, [Map<String, dynamic> additionalData]);

    String result = await AdobeAnalyticsPlugin.trackAction(
        "ACTION_NAME",
        <String, dynamic>{
            "action": "ACTION",
            "category": "TEST"
        }
    );


// Before using all above code it is mandatory to store MobileConfiguration json
 file in ios/android separately by following the below link link:
https://pub.dev/packages/adobe_mobile_sdk_flutter#-readme-tab-
 */
