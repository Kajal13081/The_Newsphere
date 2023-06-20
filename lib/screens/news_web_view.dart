import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsWebView extends StatefulWidget {

  String url;
  NewsWebView(this.url, {super.key});
  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late String finalUrl;
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    if(widget.url.toString().contains("http://"))
    {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    }
    else{
      finalUrl = widget.url;
    }
    controller = WebViewController()
    ..loadRequest(
    Uri.parse(finalUrl),
    );
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              children: [

                Text(
                  "Today's Headline",
                  style: TextStyle(
                    fontFamily: 'Source Serif 4',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1e293b),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  width: size.width,
                  height: size.height,
                  child: WebViewWidget(
                    controller: controller,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
