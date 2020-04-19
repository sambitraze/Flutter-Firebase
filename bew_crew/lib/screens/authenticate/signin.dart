import 'package:bew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bew_crew/shared/constants.dart';
import 'package:bew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function view;

  SignIn({this.view});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
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
          'Sign In to Brew Crew',
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.view();
            },
            icon: Icon(Icons.person_add),
            label: Text('Register'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: _formKey,
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
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailPass(email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          error = 'Please check credentitals entered';
                        });
                      }
                    }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//  RaisedButton(
//           child: Text('Sign in Anon'),
//           onPressed: () async {
//             dynamic result = await _auth.signInAnon();
//             if(result == null){
//               print('Couldnt sign in');
//             } else{
//               print('Signed In');
//               print(result.uid);
//             }
//           }
