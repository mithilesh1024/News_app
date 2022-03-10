import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottomRoutes.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  static int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.shifting,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      onTap: (int index){
        setState(() {
         if(_index != index){
           _index = index;
           onTapTapped(context, index);
         }
        });
      },
      currentIndex: _index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("HOME"),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Category")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("SEARCH"),
        )
      ],
    );
  }
}
