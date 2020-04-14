import 'package:bew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew')
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextField(
                onChanged: (value) {
                   
                }
              )
            ],
          ), 
        ),
        )
      
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