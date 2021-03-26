import 'package:flutter/material.dart';
import 'profile_recommendations.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class HomeActivity extends StatefulWidget {
  @override
  _HomeActivityState createState() => _HomeActivityState();
}

Widget index(int selected_index) {
  switch (selected_index) {
    case 0:
      {
        return Center(
          child: Container(
            child: Text('Tab 0'),
          ),
        );
      }
    case 1:
      {
        return Center(
          child: Container(
            child: Recommendations(),
          ),
        );
      }
    case 2:
      {
        return Center(
          child: Container(
            child: Text('Tab 2'),
          ),
        );
      }
  }
}

class _HomeActivityState extends State<HomeActivity> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: index(_selectedIndex),

        backgroundColor: Theme.of(context).primaryColor,
        // you can use the molten bar in the scaffold's bottomNavigationBar
        bottomNavigationBar: MoltenBottomNavigationBar(
          duration: Duration(milliseconds: 170),
          barColor: Theme.of(context).primaryColor,
          domeCircleColor: Theme.of(context).accentColor,
          selectedIndex: _selectedIndex,
          // specify what will happen when a tab is clicked
          onTabChange: (clickedIndex) {
            // setState(() {
            //   _selectedIndex = clickedIndex;
            // });

            setState(
              () {
                _selectedIndex = clickedIndex;
                // switch (clickedIndex) {
                //   case 0:
                //     {
                //       break;
                //     }
                //   case 1:
                //     {
                //       return Scaffold(
                //         body: Text('Potential Matches'),
                //       );
                //     }
                // }
              },
            );
          },
          // insert as many tabs as you like
          tabs: [
            MoltenTab(
              icon: Icon(Icons.search),
              selectedColor: Colors.white,
            ),
            MoltenTab(
              icon: Icon(Icons.home),
              selectedColor: Colors.white,
            ),
            MoltenTab(
              icon: Icon(Icons.person),
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
