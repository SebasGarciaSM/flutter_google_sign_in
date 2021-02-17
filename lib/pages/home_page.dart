import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/blocs/auth_bloc.dart';
import 'package:flutter_google_sign_in/pages/login_page.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.curretUser.listen((firebaseUser) { 
      if(firebaseUser==null){
        Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> LoginPage()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
      body: Center(
        child: StreamBuilder<User>(
          stream: authBloc.curretUser,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data.displayName, style: TextStyle(fontSize: 35.0),),
                SizedBox(height: 20.0),
                CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data.photoURL.replaceFirst('s96', 's400')),
                  radius: 60.0,
                ),
                SizedBox(height: 100.0),
                SignInButton(Buttons.Google, text: 'Sign Out', onPressed:()=> authBloc.logout())
              ],
            );
          }
        ),
      ),
    );
  }
}