import 'package:flutter/material.dart';
import 'package:visitapp/constants.dart';

class CompartirPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('Compartir'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Center(
            child: Image.network(
                'https://images.samsung.com/is/image/samsung/p5/au/faq/os-pie-updates/QR-code.png'),
          ),
        ],
      ),
    );
  }
}
