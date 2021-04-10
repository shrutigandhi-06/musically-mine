import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class Recommendations extends StatefulWidget {
  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  CardController _cardController = CardController();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            Center(
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
                              image: AssetImage('images/design.png'),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text('Location'),
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
            ),
          ],
        ),
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
            Center(
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
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text('Location'),
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
            ),
          ],
        ),
      ],
    );
  }
}
