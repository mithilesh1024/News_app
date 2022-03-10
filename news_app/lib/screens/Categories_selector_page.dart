import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Category_page_helper/category_page_navigator.dart';
import 'package:newsapp/Category_page_helper/data.dart';
import 'package:newsapp/Common/APP_BAR.dart';
import 'package:newsapp/Common/bottom_navigation.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APP_BAR(context),
      body: Container(
        child: GridView.builder(
          itemCount: getCategories().length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 5.0),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    categoryselected(context, index);
                  });
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Opacity(
                        child:
                            CachedNetworkImage(
                              placeholder: (context, url) => CircularProgressIndicator(),
                              imageUrl: getCategories()[index].imageAssetUrl,
                              errorWidget: (context, url ,error) => Icon(Icons.error),
                            ),
                        opacity: 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        getCategories()[index].categorieName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
