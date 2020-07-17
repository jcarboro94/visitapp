import 'package:flutter/material.dart';
import 'package:visitapp/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CompartirPage extends StatelessWidget {
  String url;

  CompartirPage(String url) {
    this.url = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('Compartir'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Center(
              child: QrImage(
            data: url,
            version: QrVersions.auto,
            size: 320,
            gapless: false,
//            embeddedImage: AssetImage('assets/images/my_embedded_image.png'),
//            embeddedImage: AssetImage(
//                '/data/user/0/com.jordicarborodriguez.visitapp/cache/image_picker6131620721346512717.jpg'),
//            embeddedImageStyle: QrEmbeddedImageStyle(
//              size: Size(80, 80),
//            ),
          ) /*Image.network(
                'https://images.samsung.com/is/image/samsung/p5/au/faq/os-pie-updates/QR-code.png')*/
              ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: RaisedButton(
              child: Text(
                'Enviar',
                style: TextStyle(color: kYellow, fontSize: 15),
              ),
              color: kDarkBlue,
              onPressed: () {
                print('I HAVE BEEN PRESSED');
              },
            ),
          )
        ],
      ),
    );
  }
}
