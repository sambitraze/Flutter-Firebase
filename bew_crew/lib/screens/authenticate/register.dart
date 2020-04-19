import 'package:bew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bew_crew/shared/constants.dart';
import 'package:bew_crew/shared/loading.dart';

class Register extends StatefulWidget {
  final Function view;

  Register({this.view});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _fromKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text(
          'Sign Up to Brew Crew',
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.view();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          )
        ],
        ),  
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (value) => value.isEmpty ? 'Enter an email' : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (value) => value.length < 6 ? 'Enter more than six characters' : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_fromKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailPass(email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          error = 'Please check credentitals entered';
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0, 
                  ),
                )
              ],
            ),
          ),
        ),);
  }
}