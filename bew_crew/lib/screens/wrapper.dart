import 'package:bew_crew/models/user.dart';
import 'package:bew_crew/screens/authenticate/authenticate.dart';
import 'package:bew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget.

    final user = Provider.of<User>(context);  
    if(user == null) {
      return Authenticate();
    }else {
      return Home();
    }

    
    
  }
}