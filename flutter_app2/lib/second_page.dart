import 'package:flutter/material.dart';
import 'package:flutter_app2/third_page.dart';

class SecondPage extends StatefulWidget {
  final String data;

  SecondPage(this.data);

  @override
  _SecondPageState createState() => _SecondPageState(data);
}

class _SecondPageState extends State<SecondPage> {
  var data;
  var editTextController = TextEditingController();

  _SecondPageState(this.data) {
    editTextController.text = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                  controller: editTextController,
                  style: TextStyle(color: Colors.blue, fontSize: 18))),
          Row(
            children: <Widget>[
              SizedBox(width: 30),
              RaisedButton(
                child: Text('<- Save'),
                onPressed: _goBack,
              )
            ],
          ),
          SizedBox(
            height: 100,
          ),
          divider(),
          SizedBox(
            height: 20,
          ),
          Text('Row with equally disctributed in children'),
          SizedBox(height: 50),
          singleRowGallery()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goNext,
        tooltip: 'going next',
        child: Text('Next'),
      ),
    );
  }

  _goNext() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ThirdPage()));
  }

  _goBack() {
    Navigator.pop(context, editTextController.text);
  }

  divider() {
    return Container(
      height: 1.5,
      color: Colors.black12,
    );
  }

  singleRowGallery() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.asset('logo.png'),
          flex: 2,
        ),
        Expanded(
          child: Image.asset('logo.png'),
          flex: 2,
        ),
        Expanded(
          child: Image.asset('logo.png'),
          flex: 2,
        )
      ],
    );
  }
}
