import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:http/http.dart' as http;
import 'questionnaire.dart';

class Recommendations extends StatefulWidget {
  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  List<String> user_id = [],
      user_name = [],
      user_age = [],
      user_city = [],
      user_state = [];

  int length = 0;

  CardController _cardController = CardController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPotentialMatches();
  }

  @override
  Widget build(BuildContext context) {
    return user_name.length == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/loader.gif',
                width: 300.0,
                height: 300.0,
              ),
              Text('Brewing your matches...'),
            ],
          )
        : Stack(
            children: [
              SwipeableCardsSection(
                context: context,
                enableSwipeUp: false,
                enableSwipeDown: false,
                cardController: _cardController,
                //cardWidthTopMul: 1,
                cardHeightTopMul: 1,
                cardHeightBottomMul: 1,
                //cardWidthBottomMul: 1,
                items: [
                  for (int i = 0; i < length; i++)
                    userCard(
                      name: user_name[i],
                      age: user_age[i],
                      city: user_city[i],
                      state: user_state[i],
                    )
                ],
              ),
            ],
          );
  }

  Widget userCard({String name, String age, String city, String state}) {
    print("Method called");
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0x30FFFFFF),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(
                  //fit: StackFit.expand,
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.75,
                      image: AssetImage('images/cake.jpg'),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              name + ', ' + age,
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(city),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Text('hiii'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getPotentialMatches() async {
    var headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'id': id,
    };

    var res = await http.post(
        'https://musically-mine.000webhostapp.com/potentialMatches.php',
        headers: headers,
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');

    print(res.request.url);

    final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
    final input = res.body;
    final result = regExp
        .allMatches(input)
        .map((m) => m.group(1))
        .map((String item) => item.replaceAll(new RegExp(r'[\[\]]'), ''))
        .map((m) => [m])
        .toList();

    for (int i = 0; i < result.length; i++) {
      final input1 =
          result[i].toString().substring(1, result[i].toString().length - 1);
      print(input1);
      var temp = input1.split(',');

      setState(() {
        length++;
      });

      user_id.add(temp[userDataIndex.id.index]
          .toString()
          .substring(1, temp[userDataIndex.id.index].toString().length - 1));
      user_name.add(temp[userDataIndex.name.index]
          .toString()
          .substring(1, temp[userDataIndex.name.index].toString().length - 1));
      user_age.add(temp[userDataIndex.age.index]
          .toString()
          .substring(1, temp[userDataIndex.age.index].toString().length - 1));
      user_city.add(temp[userDataIndex.city.index]
          .toString()
          .substring(1, temp[userDataIndex.city.index].toString().length - 1));
      user_state.add(temp[userDataIndex.state.index]
          .toString()
          .substring(1, temp[userDataIndex.state.index].toString().length - 1));
    }
  }
}

enum userDataIndex { id, name, age, city, state }
