

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget APP_BAR(BuildContext context){
  return AppBar(
    title: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: " TODAY ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              backgroundColor: Colors.red,
              fontSize: 28,
            ),
          ),
          TextSpan(
            text: " NEWS ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              backgroundColor: Colors.indigo,
              fontSize: 28,
            ),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.save),
        onPressed: (){
          Navigator.of(context).pushNamed('/fourth');
        },
      ),
    ],
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
  );
}