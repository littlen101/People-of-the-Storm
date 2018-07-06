import 'package:flutter/material.dart';

final _authenticationProviders = [
  'Email',
  'Facebook',
  'Google',
];

final _authenticationColors = [
  {'background': Colors.grey, 'text': Colors.white},
  {'background': Colors.blue[800], 'text': Colors.white},
  {'background': Colors.redAccent, 'text': Colors.white},
];

final _authenticationMethods = [
  _emailMethod,
  _facebookMethod,
  _googleMethod,
];

final _emailMethod = () => print('Tapped');
final _facebookMethod = () => print('Tapped');
final _googleMethod = () => print('Tapped');

Widget _buildButtons() {
  return ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      var _authProvider = _authenticationProviders[index];
      var _authColor = _authenticationColors[index];
      var _authMethod = _authenticationMethods[index];

      return GestureDetector(
        onTap: _authMethod,
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: _authColor['background'],
          child: Text(
            _authProvider,
            style: TextStyle(
              color: _authColor['Text'],
              fontSize: 14.0,
            ),
          ),
        ),
      );
    },
    itemCount: _authenticationProviders.length,
  );
}

Widget authenticationButtons() {
  final _buttonList = Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: _buildButtons(),
  );

  return _buttonList;
}
