import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Common/APP_BAR.dart';
import 'package:newsapp/Search_helper/SearchingNews.dart';
import 'package:newsapp/Common/bottom_navigation.dart';

import 'FullArticleView.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final databaseReference = Firestore.instance;

  String search = '';

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APP_BAR(context),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter article name to search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                controller: _controller,
                onSubmitted: (String value){
                  setState(() {
                    search = value;
                  });
                  _controller.clear();
                },
              ),
            ),
            FutureBuilder(
              future: getSearchResult(search),
              builder: (context , snapshot){
                if(search.length > 0){
                  if(snapshot.data != null){
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context , int index){
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
                                          height: 25.0,
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
                                                if(checkExist(index.toString()) == true){
                                                  await databaseReference.collection("user").add({
                                                    'title': snapshot.data[index].title,
                                                    'description': snapshot.data[index].description,
                                                    'url': snapshot.data[index].url,
                                                    'urlToImage': snapshot.data[index].urlToImage
                                                  });
                                                }
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
                          }),
                    );
                  }else{
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                }else{
                  return Text('');
                }
              },
            ),
          ],
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
