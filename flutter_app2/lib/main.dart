import 'package:flutter/material.dart';
import 'package:flutter_app2/second_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_example/bloc.dart';
import 'bloc_example/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        /*home:MyHomePage(title: 'Flutter Demo Home Page'),*/
        home: BlocProvider<CounterBloc>(
          builder: (context) => CounterBloc(),
          child: BlocSample(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var editTextController = TextEditingController();

  void gotNext() async {
    final modifiedData = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondPage(editTextController.text)))
        as String;

    editTextController.text = modifiedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(fit: StackFit.expand, children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/logo.jpg'),
          radius: 100,
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.white54,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.all(30),
                    child: TextField(
                      controller: editTextController,
                      decoration: InputDecoration(hintText: 'Enter your input'),
                    ))
              ],
            )),
        Positioned(
            left: 0,
            top: 600,
            child: RaisedButton(
              onPressed: _goToBloc,
              child: Text('Bloc Sample'),
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: gotNext,
        tooltip: 'going next',
        child: Text("Next"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _goToBloc() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BlocSample()));
  }
}
