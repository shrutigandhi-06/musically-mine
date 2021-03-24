import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class HomeActivity extends StatefulWidget {
  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Selected Tab: $_selectedIndex',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.grey,
        // you can use the molten bar in the scaffold's bottomNavigationBar
        bottomNavigationBar: MoltenBottomNavigationBar(
          duration: Duration(milliseconds: 170),
          barColor: Theme.of(context).primaryColor,
          domeCircleColor: Theme.of(context).accentColor,
          selectedIndex: _selectedIndex,
          // specify what will happen when a tab is clicked
          onTabChange: (clickedIndex) {
            setState(() {
              _selectedIndex = clickedIndex;
            });
          },
          // ansert as many tabs as you like
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
