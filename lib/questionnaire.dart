import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musically_mine/authorization.dart';

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendAuthCode();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Questionnaire'),
      ),
    );
  }

  //sending auth code to the server
  Future<void> sendAuthCode() async {
    var headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'authCode': code,
    };

    //sending authCode to the server via POST reuest
    var res = await http.post(
        'https://musically-mine.000webhostapp.com/userInsights.php',
        headers: headers,
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');

    print(res.request.url);
    print(res.body);
  }
}
