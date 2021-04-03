import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:musically_mine/authorization.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  final introKey = GlobalKey<IntroductionScreenState>();
  GlobalKey<FormState> name_key = GlobalKey<FormState>();
  GlobalKey<FormState> city_key = GlobalKey<FormState>();
  GlobalKey<FormState> state_key = GlobalKey<FormState>();
  GlobalKey<FormState> dob_key = GlobalKey<FormState>();
  bool gender_check = false;
  bool interested_gender_check = false;
  final name_controller = TextEditingController();
  final city_controller = TextEditingController();
  final state_controller = TextEditingController();
  final date_controller = TextEditingController();
  String gender, interested_gender, id;
  int user_age;

  void _onIntroEnd(context) {
    sendUserData();
    Navigator.popAndPushNamed(context, '/homeActivity');
  }

  DateTime birth_date = DateTime.now();

  Future<Null> pickBdate(BuildContext context) async {
    final date_picked = await showDatePicker(
      context: context,
      initialDate: birth_date,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark().copyWith(
              primary: const Color(0xffF6265A),
              secondary: const Color(0xffF6265A),
              secondaryVariant: const Color(0xfff6265a),
            ),
          ),
          child: child,
        );
      },
    );
    if (date_picked != null && date_picked != birth_date) {
      setState(
        () {
          birth_date = date_picked;
          date_controller.text = birth_date.day.toString() +
              '/' +
              birth_date.month.toString() +
              '/' +
              birth_date.year.toString();
          findAge(DateTime.now().day, DateTime.now().month, DateTime.now().year,
              birth_date.day, birth_date.month, birth_date.year);
        },
      );
    }
  }

  Container my_container() {
    return Container(
      margin: EdgeInsets.all(3.0),
      width: 150.0,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Wrap(
            children: [
              Image.asset('images/logo.png'),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Artist 1',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendAuthCode();
  }

  void validate() {
    double page = introKey.currentState.controller.page;
    int curr_page = page.toInt();
    print("Currently page: " + curr_page.toString());
    switch (curr_page) {
      case 0:
        {
          if (!(name_key.currentState.validate()))
            introKey.currentState.animateScroll(0);
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          break;
        }
      case 1:
        {
          if (!gender_check) introKey.currentState.animateScroll(1);
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          break;
        }
      case 2:
        {
          if (!interested_gender_check) introKey.currentState.animateScroll(2);
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          break;
        }
      case 3:
        {
          if (!(dob_key.currentState.validate()))
            introKey.currentState.animateScroll(3);
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          break;
        }
      case 4:
        {
          if (!(city_key.currentState.validate()))
            introKey.currentState.animateScroll(4);
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          break;
        }
      case 5:
        {
          if (!(state_key.currentState.validate()))
            introKey.currentState.animateScroll(5);
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: IntroductionScreen(
          key: introKey,
          pages: [
            PageViewModel(
              titleWidget: Padding(
                padding: EdgeInsets.only(top: 100.00),
                child: Text(
                  "Name?",
                  style: TextStyle(
                    color: Color(0xffF6265A),
                    fontSize: 60.0,
                    fontFamily: 'ProximaLight',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              bodyWidget: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Form(
                  key: name_key,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: name_controller,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Oops! We didn't get your name";
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.grey[700]),
                        hintText: "Your name",
                        fillColor: Color(0x50FFFFFF)),
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: Padding(
                padding: EdgeInsets.only(top: 100.00),
                child: Text(
                  "I'm",
                  style: TextStyle(
                    color: Color(0xffF6265A),
                    fontSize: 60.0,
                    fontFamily: 'ProximaLight',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              bodyWidget: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: CustomRadioButton(
                  elevation: 10,
                  enableShape: true,
                  enableButtonWrap: true,
                  wrapAlignment: WrapAlignment.center,
                  unSelectedColor: Color(0x50FFFFFF),
                  buttonLables: [
                    'Male',
                    'Female',
                  ],
                  buttonValues: [
                    "Male",
                    "Female",
                  ],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.white,
                      textStyle: TextStyle(fontSize: 16)),
                  radioButtonValue: (value) {
                    gender = value;
                    gender_check = true;
                  },
                  selectedColor: Color(0xffF6265A),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: Padding(
                padding: EdgeInsets.only(top: 100.00),
                child: Text(
                  "Interested in",
                  style: TextStyle(
                    color: Color(0xffF6265A),
                    fontSize: 60.0,
                    fontFamily: 'ProximaLight',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              bodyWidget: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: CustomRadioButton(
                  elevation: 10,
                  enableShape: true,
                  enableButtonWrap: true,
                  wrapAlignment: WrapAlignment.center,
                  unSelectedColor: Color(0x50FFFFFF),
                  buttonLables: ['Male', 'Female', 'Everyone'],
                  buttonValues: ["Male", "Female", "Everyone"],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.white,
                      textStyle: TextStyle(fontSize: 16)),
                  radioButtonValue: (value) {
                    interested_gender = value;
                    interested_gender_check = true;
                  },
                  selectedColor: Color(0xffF6265A),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: Padding(
                padding: EdgeInsets.only(top: 100.00),
                child: Text(
                  "Date of Birth",
                  style: TextStyle(
                    color: Color(0xffF6265A),
                    fontSize: 60.0,
                    fontFamily: 'ProximaLight',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              bodyWidget: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Form(
                  key: dob_key,
                  child: TextFormField(
                    controller: date_controller,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Oops! We didn't get your birth date";
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.grey[700]),
                        hintText: "Your date of birth",
                        fillColor: Color(0x50FFFFFF)),
                    onTap: () {
                      pickBdate(context);
                    },
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: Padding(
                padding: EdgeInsets.only(top: 100.00),
                child: Text(
                  "City?",
                  style: TextStyle(
                    color: Color(0xffF6265A),
                    fontSize: 60.0,
                    fontFamily: 'ProximaLight',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              bodyWidget: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Form(
                  key: city_key,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: city_controller,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Oops! We didn't get your city";
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.grey[700]),
                        hintText: "Your city",
                        fillColor: Color(0x50FFFFFF)),
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: Padding(
                padding: EdgeInsets.only(top: 100.00),
                child: Text(
                  "State?",
                  style: TextStyle(
                    color: Color(0xffF6265A),
                    fontSize: 60.0,
                    fontFamily: 'ProximaLight',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              bodyWidget: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Form(
                  key: state_key,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: state_controller,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Oops! We didn't get your state";
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.grey[700]),
                        hintText: "Your state",
                        fillColor: Color(0x50FFFFFF)),
                  ),
                ),
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: Container(
                height: 170.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    my_container(),
                    my_container(),
                    my_container(),
                  ],
                ),
              ),
            )
          ],
          onDone: () => _onIntroEnd(context),
          onChange: (int a) => validate(),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: false,
          skipFlex: 0,
          nextFlex: 0,
          skip: const Text('Skip'),
          next: const Icon(Icons.arrow_forward),
          done:
              const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0x50F6265A),
            activeColor: Color(0xffF6265A),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
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

    //sending authCode to the server via POST request
    var res = await http.post(
        'https://musically-mine.000webhostapp.com/userInsights.php',
        headers: headers,
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');

    print(res.request.url);
    String temp = res.body.toString();
    id = temp.substring(temp.length - 28, temp.length);
    print(temp);
  }

  Future<void> sendUserData() async {
    var name = name_controller.text;
    var dob = date_controller.text;
    var city = city_controller.text;
    var state = state_controller.text;

    var headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'id': id,
      'name': name,
      'gender': gender,
      'interested_gender': interested_gender,
      'age': user_age.toString(),
      'city': city,
      'state': state
    };

    //sending authCode to the server via POST reuest
    var res = await http.post(
        'https://musically-mine.000webhostapp.com/addUser.php',
        headers: headers,
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');

    print(res.request.url);
    print(res.body);
  }

  void findAge(int current_date, int current_month, int current_year,
      int birth_date, int birth_month, int birth_year) {
    var month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (birth_date > current_date) {
      current_month = current_month - 1;
      current_date = current_date + month[birth_month - 1];
    }

    if (birth_month > current_month) {
      current_year = current_year - 1;
      current_month = current_month + 12;
    }

    // calculate date, month, year
    int calculated_year = current_year - birth_year;

    // print the present age
    user_age = calculated_year;
  }
}
