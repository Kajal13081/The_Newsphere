import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/news_web_view.dart';
import 'package:share_plus/share_plus.dart';

import '../models/model.dart';
import 'news_feed.dart';

class NewsView extends StatefulWidget {
  final NewsQueryModel model;

  NewsView({super.key, required this.model});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {

  String getShareLink() {
    return "Read this news: ${widget.model.newsUrl}";
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    int newsDescriptionLength = widget.model.newsDes!.split(' ').length;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xff64748b),
                        size: 26,
                      ),
                    ),
                    SizedBox(
                      width: 281,
                    ),
                    Icon(
                      Icons.bookmark_border_rounded,
                      color: Color(0xff64748b),
                      size: 26,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Share.share(getShareLink());
                        print('share');
                      },
                      child: Icon(
                        Icons.share_rounded,
                        color: Color(0xff64748b),
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.model.newsImg != null
                        ? Container(
                            width: size.width/1.05,
                            height: size.height/3,
                            alignment: Alignment.center,
                            child: Image.network(widget.model.newsImg!,
                            fit: BoxFit.cover,)
                        )
                      : Text(
                            "Unable to load image",
                            style: TextStyle(
                            color: Color(0xff0f172a),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      Text(widget.model.newsHead ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xff0f172a)
                      ),),

                      SizedBox(height: 10,),

                      Text(
                        "${newsDescriptionLength >= 200 ? (newsDescriptionLength / 200).floor() : (newsDescriptionLength / 200 * 60).floor()} ${newsDescriptionLength >= 200 ? "mins" : "secs"} Read",
                        style: TextStyle(fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff64748b)),),

                      SizedBox(height: 8,),

                      Container(
                        width: size.width/1.05,
                        child: Text(
                          'Posted On: ${ widget.model.newsPostedOn?? ''}',
                          style: TextStyle(fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff64748b)),
                        ),
                      ),

                      SizedBox(height: 8,),

                      Container(
                        width: size.width/1.05,
                        child: Text(
                            'Posted By: ${ widget.model.newsPostedBy?? ''}',
                            style: TextStyle(fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff64748b)),
                          ),
                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: size.width/1.05,
                        child: Text(
                          widget.model.newsDes ?? '',
                          style: TextStyle(fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1e293b)),
                        ),
                      ),

                      SizedBox(height: 30,),

                      if (widget.model.newsUrl != null)
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement navigation to the news URL
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsWebView(widget.model.newsUrl.toString())));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff4c4ddc),
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                            child: Text('Read More',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                        ),

                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
