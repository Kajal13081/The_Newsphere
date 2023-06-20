import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/model.dart';
import 'package:news_app/notifier/country_provider.dart';
import 'package:provider/provider.dart';

import 'newsView.dart';
import 'news_feed.dart';

class SearchCountryNews extends StatefulWidget{
  @override
  State<SearchCountryNews> createState() => _SearchCountryNewsState();
}

class _SearchCountryNewsState extends State<SearchCountryNews> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    // final model = context.watch<CountryProvider>();

    Future<void> fetchCountryNews() async {
      await context.read<CountryProvider>().getCountryNews(
          countryname: controller.text,
          ctx: context);
    }

    final List<NewsQueryModel>? countryNews = context.watch<CountryProvider>().newsQueryModel;

    // TODO: implement build

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "Search Different Country News",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1e293b),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                    onSubmitted: (value) {
                      fetchCountryNews();
                    },
                    style: TextStyle(color: Color(0xFF4c4ddc),
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xdacdcfe0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search Country News",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Color(0xFF64748b),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748b),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsFeed()));
                      },
                      child: Text('Search news category wise',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff4c4ddc),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                // model.isLoading?Center(
                //   child: CircularProgressIndicator(
                //     backgroundColor: Color(0xFF4c4ddc),
                //   ),
                // )
                //     : const SizedBox.shrink(),
                //
                // SizedBox(height: 30,),

                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    List.generate(countryNews?.length ?? 0, (index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewsView(
                              model: countryNews[index],
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
                                  padding: const EdgeInsets.fromLTRB(
                                      5, 6.5, 0, 6.5),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    child: countryNews![index].newsImg !=
                                        null
                                        ? Image.network(
                                      key: Key(countryNews[index]
                                          .newsImg
                                          .toString()),
                                      countryNews[index]
                                          .newsImg
                                          .toString(),
                                      height: 150,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    )
                                        : Icon(
                                      Icons.image,
                                      size: 130,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 5, 0, 5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width: size.width/2,
                                          child: Text(
                                            getTruncatedTitle(
                                                countryNews[index]
                                                    .newsHead
                                                    .toString(),
                                                50),
                                            maxLines: 3,
                                            overflow:
                                            TextOverflow.ellipsis,
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
                                                  countryNews[index]
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
                                                  countryNews[index]
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
              ],
            ),
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
        ? actualString.substring(0, 10) + "at" + actualString.substring(11, maxLetters) + "..."
        : actualString;
  }
}