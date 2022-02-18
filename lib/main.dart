import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:musically_mine/homeActivity.dart';
import 'package:musically_mine/questionnaire.dart';
import 'authorization.dart';
import 'user_profile.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'ProximaLight'),
        primaryColor: Color(0xff13131B),
        accentColor: Color(0xffF6265A),
        scaffoldBackgroundColor: Color(0xff13131B),
      ),
      home: SignUp(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/authorization': (context) => Authorization(),
        '/questionnaire': (context) => Questionnaire(),
        '/homeActivity': (context) => HomeActivity(),
        '/userProfile': (context) => UserProfile()
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
              Image(
                image: AssetImage('images/musicallyMineLogo.png'),
                width: MediaQuery.of(context).size.height * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Musically Mine',
                style: TextStyle(fontFamily: 'ProximaLight', fontSize: 25.00),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 70.0, horizontal: 60.0),
                color: Color(0xff1DB954),
                child: ListTile(
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/authorization');
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
