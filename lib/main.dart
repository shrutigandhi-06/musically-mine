import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:musically_mine/questionnaire.dart';
import 'authorization.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff13131B),
        accentColor: Color(0xffF6265A),
        scaffoldBackgroundColor: Color(0xff13131B),
      ),
      home: SignUp(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/authorization': (context) => Authorization(),
        '/questionnaire': (context) => Questionnaire(),
      },
    ),
  );
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              Text(
                'Musically Mine',
                style: TextStyle(fontFamily: 'CaveatBrush', fontSize: 25.00),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 70.0, horizontal: 60.0),
                color: Color(0xff1DB954),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/authorization');
                  },
                  leading: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset('images/spotify_icon.png'),
                  ),
                  title: Text(
                    'Connect with Spotify',
                    textAlign: TextAlign.start,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
