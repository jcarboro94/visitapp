import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visitapp/configuracionPage.dart';
import 'package:visitapp/constants.dart';
import 'configuracionPage.dart';
import 'compartirPage.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard/vcard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = "VisitApp";
  String _firstName = "Visit";
  String _lastName = "App";

  String _description = "Share it, Keep it";

  String _phoneNumber = "987654321";

  String _email = "info@visitapp.com";

  String _url = 'www.visitapp.com';

  String _address = 'Calle Wallaby, 42, Sydney';

  String _imagePath = '';

  CircleAvatar circleAvatar() {
    if (_imagePath != '') {
      return CircleAvatar(
        backgroundImage: AssetImage(_imagePath),
      );
    } else {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/appstore.png'),
      );
    }
  }

  static GlobalKey previewContainer = GlobalKey();
  var scr = new GlobalKey();

  takeScreenShot() async {
    if (context != null) {
      RenderRepaintBoundary boundary =
          previewContainer.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print('HOLAAA!');
      print('THIS IS PNGBTES $pngBytes');
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
    }
  }

  takescrshot() async {
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();

    print(pngBytes);
//    DELETE FROM HERE
//    final directory = (await getApplicationDocumentsDirectory()).path;
//    File imgFile = new File('$directory/screenshot.png');
//    imgFile.writeAsBytes(pngBytes);
  }

  String generateVcard() {
    var vCard = VCard();
    vCard.firstName = _firstName;
    vCard.middleName = '';
    vCard.lastName = _lastName;
    vCard.organization = '';
//    vCard.photo.embedFromFile(_imagePath);
//    if (_imagePath != '') {
//      vCard.photo.embedFromFile(
//              _imagePath) /*attachFromUrl(
//        'https://www.activspaces.com/wp-content/uploads/2019/01/ActivSpaces-Logo_Dark.png',
//        'PNG');*/
//          ;
//    }
    vCard.workAddress.label = _address;
    vCard.workPhone = _phoneNumber;
//    vCard.birthday = DateTime.now();
    vCard.jobTitle = _description;
    vCard.url = _url;
//    vCard.note = 'Notes on contact';
    print('THE VCARD IS:');
    print(vCard.getFormattedString());
    return vCard.getFormattedString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('VisitApp'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: kDarkBlue),
                accountName: Text('Appsesoria'),
                accountEmail: Text('info@appsesoria.com'),
                currentAccountPicture:
                    circleAvatar() /*CircleAvatar(
                backgroundImage: (NetworkImage(
                    'https://is3-ssl.mzstatic.com/image/thumb/Purple123/v4/8a/51/76/8a517657-7b3b-071c-03ce-90efccac5c2d/source/512x512bb.jpg')),
              ),*/
                ),
            ListTile(
              title: Text('Configurar tarjeta'),
              onTap: () async {
                print('Going to Configurar Tarjeta');
                Navigator.of(context).pop();

                var contactDetails = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ConfiguracionPage()),
                );
                print(contactDetails);
                if (contactDetails != null) {
                  setState(() {
                    _name = contactDetails[0];
                    _firstName = contactDetails[1];
                    _lastName = contactDetails[2];
                    _description = contactDetails[3];
                    _phoneNumber = contactDetails[4];
                    _email = contactDetails[5];
                    _url = contactDetails[6];
                    _address = contactDetails[7];
                    _imagePath = contactDetails[8];
                  });
                }
              },
            ),
            ListTile(
              title: Text('Compartir'),
              onTap: () {
                print('Going to the other page');
//                takeScreenShot();
                takescrshot();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CompartirPage(
                      generateVcard(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Sobre VisitApp'),
              onTap: () {
                print('Going to the other page');
                showAboutDialog(
                    context: context,
                    applicationName: 'VisitApp',
                    applicationIcon: CircleAvatar(
                      backgroundImage: AssetImage('assets/appstore.png'),
//                      child: Image(
//                        image: AssetImage('assets/appstore.png'),
//                        height: 50,
//                      ),
                    ),
                    applicationLegalese: 'VisitApp no tiene acceso ni, por '
                        'supuesto almacena sus imágenes ni contactos.');
              },
            )
          ],
        ),
      ),
      backgroundColor: kLightBlue,
      body: RepaintBoundary(
        key: scr,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Container(
                    child: circleAvatar(),
                    height: 100,
                    width: 100,
                  ),
                  /*CircleAvatar(
                    radius: 50,
//                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(
                        'https://is3-ssl.mzstatic.com/image/thumb/Purple123/v4/8a/51/76/8a517657-7b3b-071c-03ce-90efccac5c2d/source/512x512bb.jpg'),
                  ),*/
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                //height: 80,
                child: Center(
                  child: Text(
                    _name,
                    style: TextStyle(
                        color: kDarkBlue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                //height: 80,
                child: Center(
                  child: Text(
                    _description.toUpperCase(),
                    style: TextStyle(
                      color: kYellow,
                      fontSize: 18,
                      letterSpacing: 2.5,
                      fontFamily: 'SourceSansPro',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
                child: Divider(
                  color: kLightBlue,
                ),
              ),
              GestureDetector(
                onTap: takescrshot,
                child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone_iphone,
                        color: kDarkBlue,
                      ),
                      title: Text(
                        _phoneNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSansPro',
                            fontSize: 15,
                            color: kDarkBlue),
                      ),
                    )),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: kDarkBlue,
                  ),
                  title: Text(
                    _email,
                    style: TextStyle(
                      color: kDarkBlue,
                      fontFamily: 'SourceSansPro',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                    leading: Icon(
                      Icons.web,
                      color: kDarkBlue,
                    ),
                    title: Text(
                      _url,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSansPro',
                          fontSize: 15,
                          color: kDarkBlue),
                    ),
                  )),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Icon(
                      Icons.location_city,
                      color: kDarkBlue,
                    ),
                    title: Text(
                      _address,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSansPro',
                          fontSize: 15,
                          color: kDarkBlue),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
