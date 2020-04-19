import 'package:bew_crew/models/user.dart';
import 'package:bew_crew/services/database.dart';
import 'package:bew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Update your Preferences',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (value) => value.isEmpty ? 'Enter a name' : null,
                  onChanged: (value) => _currentName = value,
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  iconEnabledColor: Colors.black,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    }),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
