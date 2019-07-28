import 'package:flutter/material.dart';

class FourthPage extends StatefulWidget {
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  bool _value = false;
  String textVal = "Switch On";

  void _onChanged(bool value) {
    setState(() {
      _value = value;
      textVal = _value ? 'Switch On' : 'Switch Off';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Testing Switches'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new SwitchListTile(
                value: _value,
                onChanged: _onChanged,
                title: new Text(textVal,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
