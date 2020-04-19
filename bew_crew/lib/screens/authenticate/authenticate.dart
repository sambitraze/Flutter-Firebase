import 'package:bew_crew/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';
import 'package:bew_crew/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
   if(showSignIn){
      return SignIn(view: toggleView);
   }else{
     return Register(view: toggleView);
   }
  }
}