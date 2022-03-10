import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Common/APP_BAR.dart';

import 'FullArticleView.dart';

class SavedNews extends StatefulWidget {
  @override
  _SavedNewsState createState() => _SavedNewsState();
}

class _SavedNewsState extends State<SavedNews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: APP_BAR(context),
        body: StreamBuilder(
          stream: Firestore.instance.collection('user').snapshots(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FullArticleView(
                              '${snapshot.data.documents[index]['url']}'
                          )
                      ));
                    },
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              CachedNetworkImage(
                                errorWidget: (context , url, error) => Icon(Icons.error),
                                placeholder: (context , url) => CircularProgressIndicator(),
                                imageUrl: snapshot.data.documents[index]['urlToImage'],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                snapshot.data.documents[index]['title'],
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                snapshot.data.documents[index]['description'],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
