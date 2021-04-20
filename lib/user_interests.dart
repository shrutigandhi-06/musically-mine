import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/services.dart';
import 'user_profile.dart';

class UserInterests extends StatefulWidget {
  @override
  _UserInterestsState createState() => _UserInterestsState();
}

final formKey = GlobalKey<FormState>();
List<String> formValue;

List<String> options = [
  'Road Trip',
  'Dancing',
  'Fashion',
  'Sports',
  'Travel',
  'Road Trip',
  'Dancing',
  'Fashion',
  'Sports',
  'Travel',
  'Foodie',
  'Techie',
  'Comedy',
  'Bollywood',
  'Art',
  'Baking',
  'Instagram',
  'Cooking',
  'Photography',
  'Music',
  'Cycling',
  'Video Games',
  'Outdoors',
  'Board Games',
  'Reading',
  'DIY',
  'Tea',
  'Coffee',
  'Poetry',
  'Writing',
  'Dog Lover',
  'Cat Lover',
  'Animal Lover',
  'Athlete',
  'Hiking',
  'Gamer',
  'Gardening',
  'Astrology',
  'Astronomy',
  'Spirituality'
];

class _UserInterestsState extends State<UserInterests> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'ProximaLight'),
        primaryColor: Color(0xff13131B),
        accentColor: Color(0xffF6265A),
        scaffoldBackgroundColor: Color(0xff13131B),
      ),
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: Theme.of(context).accentColor,
              child: ListTile(
                title: Text(
                  'Interests',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle:
                    Text('Makes it easier to find who shares your interests.'),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Content(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        FormField<List<String>>(
                          autovalidate: true,
                          initialValue: formValue,
                          onSaved: (val) => setState(() => formValue = val),
                          validator: (value) {
                            if (value?.isEmpty ?? value == null) {
                              return 'Please select some categories';
                            }
                            if (value.length > 5) {
                              return "Can't select more than 5 categories";
                            }
                            return null;
                          },
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    child: ChipsChoice<String>.multiple(
                                      value: state.value,
                                      onChanged: (val) {
                                        state.didChange(val);
                                        formKey.currentState.save();
                                        setState(() {
                                          interests = val;
                                        });
                                        updateUserProfile();
                                        print(interests);
                                      },
                                      choiceItems:
                                          C2Choice.listFrom<String, String>(
                                        source: options,
                                        value: (i, v) => v,
                                        label: (i, v) => v,
                                      ),
                                      choiceStyle: const C2ChoiceStyle(
                                        color: Colors.grey,
                                        borderOpacity: .3,
                                      ),
                                      choiceActiveStyle: const C2ChoiceStyle(
                                        color: Color(0xffF6265A),
                                        brightness: Brightness.dark,
                                      ),
                                      wrapped: true,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ??
                                          state.value.length.toString() +
                                              '/5 selected',
                                      style: TextStyle(
                                          color: state.hasError
                                              ? Colors.redAccent
                                              : Colors.green),
                                    ))
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final Widget child;

  Content({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content>
    with AutomaticKeepAliveClientMixin<Content> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 0.0,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(fit: FlexFit.loose, child: widget.child),
        ],
      ),
    );
  }
}
