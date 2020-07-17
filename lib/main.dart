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
import 'package:shared_preferences/shared_preferences.dart';

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

//Future<String> _getStringFromSharedPref(String parameter) async {
//  final prefs = await SharedPreferences.getInstance();
//  final name = prefs.getString(parameter);
//  if (parameter == null) {
//    return '';
//  }
//  return parameter;
//}

//Future<void> _saveStringInSharedPref(String parameter, String value) async {
//  final prefs = await SharedPreferences.getInstance();
//  await prefs.setString(parameter, value);
//}

class _HomeScreenState extends State<HomeScreen> {
  String _name;

  String _firstName;

  String _lastName;

  String _description;

  String _phoneNumber;

  String _email;

  String _url;

  String _address;

  String _imagePath;

  CircleAvatar circleAvatar() {
    if (_imagePath != null) {
      return CircleAvatar(
        backgroundColor: kDarkBlue,
        backgroundImage: AssetImage(_imagePath),
      );
    } else {
      return CircleAvatar(
        backgroundColor: kDarkBlue,
        backgroundImage: AssetImage('assets/appstore.png'),
      );
    }
  }

//  static GlobalKey previewContainer = GlobalKey();
//  var scr = new GlobalKey();

//  takeScreenShot() async {
//    if (context != null) {
//      RenderRepaintBoundary boundary =
//          previewContainer.currentContext.findRenderObject();
//      ui.Image image = await boundary.toImage();
//      final directory = (await getApplicationDocumentsDirectory()).path;
//      ByteData byteData =
//          await image.toByteData(format: ui.ImageByteFormat.png);
//      Uint8List pngBytes = byteData.buffer.asUint8List();
//      print('HOLAAA!');
//      print('THIS IS PNGBTES $pngBytes');
//      File imgFile = new File('$directory/screenshot.png');
//      imgFile.writeAsBytes(pngBytes);
//    }
//  }

//  takescrshot() async {
//    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
//    var image = await boundary.toImage();
//    var byteData = await image.toByteData(format: ImageByteFormat.png);
//    var pngBytes = byteData.buffer.asUint8List();
//
//    print(pngBytes);
////    DELETE FROM HERE
////    final directory = (await getApplicationDocumentsDirectory()).path;
////    File imgFile = new File('$directory/screenshot.png');
////    imgFile.writeAsBytes(pngBytes);
//  }

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
    vCard.workEmail = _email;
    vCard.photo.attachFromUrl(_imagePath, 'PNG');
    vCard.workPhone = _phoneNumber;
//    vCard.birthday = DateTime.now();
    vCard.jobTitle = _description;
    vCard.url = _url;
//    vCard.note = 'Notes on contact';
    print('THE VCARD IS:');
    print(vCard.getFormattedString());
    return vCard.getFormattedString();
  }

  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'VisitApp';
      _firstName = prefs.getString('firstName') ?? 'Visit';
      _lastName = prefs.getString('lastName') ?? 'App';
      _description = prefs.getString('description') ?? 'Share it, Keep it';
      _phoneNumber = prefs.getString('phoneNumber') ?? '987654321';
      _email = prefs.getString('email') ?? 'info@visitapp.com';
      _url = prefs.getString('url') ?? 'www.visitapp.com';
      _address = prefs.getString('address') ?? 'Calle Wallaby, 42, Sydney';
      _imagePath = prefs.getString('imagePath') ?? 'assets/appstore.png';
      print('THE IMAGE PATH IS $_imagePath');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT METHOD GETS CALLED!');
    getPreferences();
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
                accountName: Text(_name),
                accountEmail: Text(_email),
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
//                takescrshot();
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
      body: SingleChildScrollView(
        child: RepaintBoundary(
//        key: scr,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
//              Image(
//                image: AssetImage(
//                    '/Users/jordicarborodriguez/Library/Developer/CoreSimulator/Devices/7C5EEB8B-8A20-4DDE-890E-B94ACF9C1C79/data/Containers/Data/Application/1C9E67DA-A426-4B17-98EE-7EDAB0144262/tmp/image_picker_08AD15D8-CBCC-4BAC-A360-50D8BA3C6A83-38264-000013C0BF644FB9.jpg'),
//              ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Container(
                      child: Hero(
                        tag: 'image',
                        child: circleAvatar(),
                      ),
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
                      textAlign: TextAlign.center,
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
//                onTap: takescrshot,
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
      ),
    );
  }
}
