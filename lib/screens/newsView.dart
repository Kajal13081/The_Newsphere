import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
import 'news_feed.dart';

class NewsView extends StatefulWidget{

  final NewsQueryModel model;

  NewsView(NewsQueryModel newsModelList, this.model);


  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20,16,16),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsFeed()));
                      },
                      child: Icon(Icons.arrow_back_rounded,
                      color: Color(0xff64748b),
                      size: 26,),
                    ),

                    SizedBox(width: 281,),

                    Icon(Icons.bookmark_border_rounded,
                      color: Color(0xff64748b),
                      size: 26,),

                    SizedBox(width: 20,),

                    Icon(Icons.share_rounded,
                      color: Color(0xff64748b),
                      size: 26,),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: size.width/1.05,
                height: size.height/3,
                alignment: Alignment.center,
                // child: Image.network(
                //   New
                //
                // ),
              )
            ],
          ),
        ),
      ),
    );

  }
}