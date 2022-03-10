import 'package:flutter/material.dart';


onTapTapped(BuildContext context, int index){
  switch(index){
    case 0:
      Navigator.of(context).pushNamed('/');
      break;
    case 1:
      Navigator.of(context).pushNamed('/second');
      break;
    case 2:
      Navigator.of(context).pushNamed('/third');
      break;
    default:
      print("NAvigator problem");
  }
}