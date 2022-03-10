import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Common/APP_BAR.dart';
import 'package:newsapp/home_page_modules/NewsData.dart';
import 'package:newsapp/screens/FullArticleView.dart';
import 'package:newsapp/Common/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APP_BAR(context),
      body: Container(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: FutureBuilder(
          future: getNewsData(),
          builder: (context, snapshot){
            if(snapshot.data != null) {
                return ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context ,int index){
                    return Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FullArticleView(
                                  '${snapshot.data[index].url}'
                              )
                          ));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                CachedNetworkImage(
                                  errorWidget: (context , url, error) => Icon(Icons.error),
                                  placeholder: (context , url) => CircularProgressIndicator(),
                                  imageUrl: snapshot.data[index].urlToImage,
                                ),
//                                  Image.network(snapshot.data[index].urlToImage),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    snapshot.data[index].title,
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    snapshot.data[index].description,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 18.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      color: Colors.black,
                                      iconSize: 30,
                                      icon: Icon(Icons.save),
                                      onPressed: () async {
                                        // ignore: unrelated_type_equality_checks
                                          await databaseReference.collection("user").add({
                                            'title': snapshot.data[index].title,
                                            'description': snapshot.data[index].description,
                                            'url': snapshot.data[index].url,
                                            'urlToImage': snapshot.data[index].urlToImage
                                          });
                                      },
                                    ),
                                  ],
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
      bottomNavigationBar: BottomNavigation(),
    );
  }
  Future<bool> checkExist(String docID) async{
    bool exist = false;
    try {
      databaseReference.document('user/$docID').get().then((doc) => {
        if(doc.exists){
          exist = true,
        }else{
          exist = false,
        }
      });
      return true;
    }catch(e){
      return false;
    }
  }
}

