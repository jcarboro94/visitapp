import 'package:flutter/material.dart';
import 'package:visitapp/constants.dart';

class ConfiguracionPage extends StatefulWidget {
  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  String _name;
  String _description;
  String _phoneNumber;
  String _email;
  String _url;
  String _address;
  Color _mainColor;
  Color _secondColor;
  Color _thirdColor;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('Edita tu tarjeta'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    list.add(_description);
                    list.add(_phoneNumber);
                    list.add(_email);
                    list.add(_url);
                    list.add(_address);

                    Navigator.pop(context, list);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
