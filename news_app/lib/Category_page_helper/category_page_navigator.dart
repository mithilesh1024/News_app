import 'package:flutter/material.dart';
import 'package:newsapp/screens/News_category.dart';

categoryselected(BuildContext context, int index){
  switch(index){
    case 0:
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => BusinessCategory(
          'business'
        )
      ));
      break;
    case 1:
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BusinessCategory(
              'entertainment'
          )
      ));
      break;
    case 2:
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BusinessCategory(
              'general'
          )
      ));
      break;
    case 3:
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BusinessCategory(
              'health'
          )
      ));
      break;
    case 4:
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BusinessCategory(
              'science'
          )
      ));
      break;
    case 5:
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BusinessCategory(
              'sports'
          )
      ));
      break;
    case 6:
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BusinessCategory(
              'technology'
          )
      ));
      break;
    default:
      print("Something went wrong");
  }
 }