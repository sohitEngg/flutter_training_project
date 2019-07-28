import 'package:flutter/material.dart';

import 'fourth_page.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(20),
      child: _buildGrid(),
    );
  }

  _goNext() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FourthPage()));
  }

  _buildGrid() {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      children: _buildGridListing(30),
      padding: EdgeInsets.all(5),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
    );
  }

  _buildGridListing(int count) => List.generate(
      count,
      (i) => GridTile(
              child: GestureDetector(
            child: Image.asset('logo.png'),
                onTap: _goNext,
          )));
}
