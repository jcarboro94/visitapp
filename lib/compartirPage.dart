import 'package:flutter/material.dart';
import 'package:visitapp/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:vcard/vcard.dart';

class CompartirPage extends StatelessWidget {
  String url;
  VCard finalVcard;
//  String _url;
//  String _address;
//  String _email;
//  String _firstName;
//  String _lastName;
//  String _phoneNumber;
//  String _description;

  CompartirPage(String url, VCard finalVcard) {
    this.url = url;
    this.finalVcard = finalVcard;
  }

  String textToShare() {
    if (finalVcard.firstName != '' ||
        finalVcard.lastName != '' ||
        finalVcard.email != '' ||
        finalVcard.workPhone != '' ||
        finalVcard.url != null ||
        finalVcard.workAddress != '') {
      return 'Hola! A continuación puedes ver mis datos de contacto:\n'
          'Nombre: ${finalVcard.firstName} ${finalVcard.lastName}\n'
          'Teléfono ${finalVcard.workPhone}\n'
          'Correo electrónico ${finalVcard.workEmail}\n'
          'Página web ${finalVcard.url}\n'
          'Dirección ${finalVcard.homeAddress.street}';
    }
  }

  void share(BuildContext context, VCard vcard) {
    var vCard = VCard();
//    vCard.firstName = _firstName;
//    vCard.middleName = '';
//    vCard.lastName = _lastName;
//    vCard.organization = '';
//    vCard.note =
////    vCard.photo.embedFromFile(_imagePath);
////    if (_imagePath != '') {
////      vCard.photo.embedFromFile(
////              _imagePath) /*attachFromUrl(
////        'https://www.activspaces.com/wp-content/uploads/2019/01/ActivSpaces-Logo_Dark.png',
////        'PNG');*/
////          ;
////    }
//    vCard.workAddress.label = _address;
//    vCard.workEmail = _email;
////    vCard.photo.attachFromUrl(_imagePath, 'PNG');
//    vCard.workPhone = _phoneNumber;
////    vCard.birthday = DateTime.now();
//    vCard.jobTitle = _description;
//    vCard.url = _url;
//    vCard.note = 'Notes on contact';
    print('THE VCARD IS:');
    print(vCard.getFormattedString());
//    return vCard.getFormattedString();
    final RenderBox box = context.findRenderObject();
    Share.share(vCard.getFormattedString(),
        subject: 'VisitApp',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
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
                Share.share(textToShare(),
                    subject: 'Look what I '
                        'made!');
              },
            ),
          )
        ],
      ),
    );
  }
}
