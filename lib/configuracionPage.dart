import 'package:flutter/material.dart';
import 'package:visitapp/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ConfiguracionPage extends StatefulWidget {
  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      print(pickedFile.path);
    });
  }

  String _name;
  String _firstName;
  String _lastName;
  String _description;
  String _phoneNumber;
  String _email;
  String _url;
  String _address;
  Color _mainColor;
  Color _secondColor;
  Color _thirdColor;

  ConfiguracionPage(
      String name,
      String firstName,
      String lastName,
      String description,
      String phoneNumber,
      String email,
      String url,
      String address) {
    this._name = name;
    this._firstName = firstName;
    this._lastName = lastName;
    this._description = description;
    this._phoneNumber = phoneNumber;
    this._email = email;
    this._url = url;
    this._address = address;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildImageField() {
    return GestureDetector(
      child: _image == null
          ? CircleAvatar(
              child: Icon(Icons.add_a_photo),
              backgroundColor: kDarkBlue,
              radius: 50,
            )
          : CircleAvatar(
//              child: Image.file(_image),
//              backgroundImage: NetworkImage(
//                  'https://media-exp1.licdn.com/dms/image/C5603AQFh6ytryTUsaA/profile-displayphoto-shrink_200_200/0?e=1598486400&v=beta&t=vu4Bz7Gpo2zSfAaLH4eWL6BlxfqU6Uz1MB8aM-okVKk'),
              backgroundImage: AssetImage(_image.path),
              radius: 50,
              backgroundColor: kDarkBlue,
            ),
      onTap: () {
        print('I HAVE '
            'BEEN TAPPED!');
        getImage();
      },
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nombre es obligatorio';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
        var firstAndLast = value.split(" ");
        if (firstAndLast.length > 1) {
          _firstName = firstAndLast[0];
          firstAndLast.removeAt(0);
          _lastName = firstAndLast.join(" ");
        } else {
          _firstName = firstAndLast[0];
          _lastName = '';
        }

//        if (value.split("\\w+").length > 1) {
//          _firstName = value.substring(value.lastIndexOf(" ") + 1);
//          _lastName = value.substring(0, value.lastIndexOf(' '));
//        } else {
//          _firstName = value;
//          _lastName = '';
//        }
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Descripción'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'La descripción es obligatoria';
        }
        return null;
      },
      onSaved: (String value) {
        _description = value;
      },
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Telefono'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int phoneNumber = int.tryParse(value);
        if (value.isEmpty) {
          return 'Teléfono es obligatorio';
        }
        if (phoneNumber <= 0 || phoneNumber > 999999999) {
          return 'Teléfono no existe';
        }
        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Correo electrónico'),
      keyboardType: TextInputType.emailAddress,
//      textInputAction: TextInputAction.continueAction,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Correo electrónico es obligatorio';
        }
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9"
                r".!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Por favor, introduce un email válido';
        }
        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildURLField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Página Web'),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Página web es obligatoria';
        }
        return null;
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Dirección'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Dirección es obligatoria';
        }
        return null;
      },
      onSaved: (String value) {
        _address = value;
      },
    );
  }

  Widget _buildMainColorField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Telefono'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Teléfono es obligatorio';
        }
        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildSecondColorField() {
    return null;
  }

  Widget _buildThirdColorField() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('Edita tu tarjeta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildImageField(),
                  _buildNameField(),
                  _buildDescriptionField(),
                  _buildPhoneNumberField(),
                  _buildEmailField(),
                  _buildURLField(),
                  _buildAddressField(),
                  SizedBox(
                    height: 100,
                  ),
                  RaisedButton(
                    child: Text(
                      'Guardar',
                      style: TextStyle(color: kYellow, fontSize: 15),
                    ),
                    color: kDarkBlue,
                    onPressed: () {
                      print('SAVED');
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      print(_name);
                      print(_description);
                      print(_phoneNumber);
                      print(_email);
                      print(_url);
                      print(_address);

                      List<String> list = List<String>();
                      list.add(_name);
                      list.add(_firstName);
                      list.add(_lastName);
                      list.add(_description);
                      list.add(_phoneNumber);
                      list.add(_email);
                      list.add(_url);
                      list.add(_address);
                      list.add(_image.path);

                      Navigator.pop(context, list);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
