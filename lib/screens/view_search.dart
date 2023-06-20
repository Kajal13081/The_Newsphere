import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/model.dart';
import 'newsView.dart';

class ViewSearch extends StatefulWidget {
  String Query;
  ViewSearch({required this.Query});
  @override
  State<ViewSearch> createState() => _ViewSearchState();
}

class _ViewSearchState extends State<ViewSearch> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];

  List<String> listpath = [
    'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=920d527c3d8642eea92327e0e59936ef',
    'https://newsapi.org/v2/top-headlines?country=in&apiKey=920d527c3d8642eea92327e0e59936ef',
    'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=920d527c3d8642eea92327e0e59936ef',
    'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=920d527c3d8642eea92327e0e59936ef',
    'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=920d527c3d8642eea92327e0e59936ef',
    'https://newsapi.org/v2/top-headlines?category=sports&apiKey=920d527c3d8642eea92327e0e59936ef'
  ];

  getNewsByQuery(String query) async {
    // String url = "";
    // if(query=="Top News") {
    //   url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=920d527c3d8642eea92327e0e59936ef";
    // }
    // if(query == "India"){
    //   url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=920d527c3d8642eea92327e0e59936ef";
    // }
    // if(query == "World News"){
    //   url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=920d527c3d8642eea92327e0e59936ef";
    // }
    // if(query == "Technology"){
    //   url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=920d527c3d8642eea92327e0e59936ef";
    // }
    // if(query == "Business"){
    //   url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=920d527c3d8642eea92327e0e59936ef";
    // }
    // if(query == "Sports"){
    //   url = "https://newsapi.org/v2/top-headlines?category=sports&apiKey=920d527c3d8642eea92327e0e59936ef";
    // }
    // else{
    //   url ="https://newsapi.org/v2/everything?q=$query&from=2023-06-10&sortBy=publishedAt&apiKey=9bb7bf6152d147ad8ba14cd0e7452f2f";
    // }

    Response response = await get(Uri.parse(query));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery(listpath[0]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(newsModelList.length, (index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewsView(
                      model: newsModelList[index],
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Container(
                    width: size.width,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xdacdcfe0),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 6.5, 0, 6.5),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: newsModelList[index].newsImg != null
                                  ? Image.network(
                                newsModelList[index].newsImg.toString(),
                                fit: BoxFit.fitHeight,
                                width: double.infinity,
                              )
                                  : Icon(
                                Icons.image,
                                size: double.infinity,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 4, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: SizedBox(
                                  width: size.width/2,
                                  child: Text(
                                    getTruncatedTitle(
                                        newsModelList[index]
                                            .newsHead
                                            .toString(),
                                        50),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff0f172a),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: size.width/2,
                                child: Text(
                                  "Posted By: " +
                                      getTruncatedAuthor(
                                          newsModelList[index]
                                              .newsPostedBy
                                              .toString(),
                                          30),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff64748b),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: size.width/2,
                                child: Text(
                                  "Posted On: " +
                                      getTruncatedDate(
                                          newsModelList[index]
                                              .newsPostedOn
                                              .toString(),
                                          30),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff64748b),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + ".."
        : actualString;
  }
  String getTruncatedAuthor(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + ".."
        : actualString;
  }
  String getTruncatedDate(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, 9) + "at" + actualString.substring(10, maxLetters) + "..."
        : actualString;
  }
}
