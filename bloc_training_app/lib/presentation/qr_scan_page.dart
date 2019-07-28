import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScanPage> {
  String _barcode = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child:
                  RaisedButton(onPressed: () => _scan(), child: Text('SCAN')),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(_barcode.length > 0
                  ? _barcode
                  : 'Code will be displayed here'),
            )
          ],
        ),
      ),
    );
  }

  _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._barcode = barcode);
    } catch (e) {
      setState(() => this._barcode = 'Unknwon error : $e');
    }
  }
}
