import 'package:flutter/material.dart';
import 'package:visitapp/configuracionPage.dart';
import 'package:visitapp/constants.dart';
import 'configuracionPage.dart';
import 'compartirPage.dart';

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
  String _name = "Jordi Carbó Rodríguez";

  String _description = "iOS and Flutter Developer";

  String _phoneNumber = "623198118";

  String _email = "info@appsesoria.com";

  String _url = 'www.appsesoria.com';

  String _address = 'Carrer del Ajuntament, 18, Barceona';

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
              currentAccountPicture: CircleAvatar(
                backgroundImage: (NetworkImage(
                    'https://is3-ssl.mzstatic.com/image/thumb/Purple123/v4/8a/51/76/8a517657-7b3b-071c-03ce-90efccac5c2d/source/512x512bb.jpg')),
              ),
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
                    _description = contactDetails[1];
                    _phoneNumber = contactDetails[2];
                    _email = contactDetails[3];
                    _url = contactDetails[4];
                    _address = contactDetails[5];
                  });
                }
              },
            ),
            ListTile(
              title: Text('Compartir'),
              onTap: () {
                print('Going to the other page');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CompartirPage()),
                );
              },
            ),
            ListTile(
              title: Text('Tarjetas guardadas'),
              onTap: () {
                print('Going to the other page');
              },
            )
          ],
        ),
      ),
      backgroundColor: kLightBlue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Center(
                child: CircleAvatar(
                  radius: 50,
//                    backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(
                      'https://is3-ssl.mzstatic.com/image/thumb/Purple123/v4/8a/51/76/8a517657-7b3b-071c-03ce-90efccac5c2d/source/512x512bb.jpg'),
                ),
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
            Card(
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
    );
  }
}
