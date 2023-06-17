import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/models/model.dart';

class Demo extends StatefulWidget{
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {

  List<String> categoryItem = ["Top News" , "India" , "World News" , "Technology", "Business" , "Sports"];
  int selectedCategoryIndex = 0;

  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];

  List<String > lispath=['https://newsapi.org/v2/everything?domains=wsj.com&apiKey=920d527c3d8642eea92327e0e59936ef','https://newsapi.org/v2/top-headlines?country=in&apiKey=920d527c3d8642eea92327e0e59936ef'];
// listpath means lis[0]='top news' ex
  bool isLoading = true;
  getNewsByQuery(String query) async {
    try{
      String url =
      "https://newsapi.org/v2/everything?q=$query&from=2023-05-28&sortBy=publishedAt&apiKey=920d527c3d8642eea92327e0e59936ef";  //how add category for this api , any key ?
      // String url="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=920d527c3d8642eea92327e0e59936ef";

      Response response = await get(Uri.parse(url));

      Map data = jsonDecode(response.body);
      setState(() {
        newsModelList.clear();
        data["articles"].forEach((element) {
          NewsQueryModel newsQueryModel = NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(element);
          newsModelList.add(newsQueryModel);

          print(newsModelList.length);

          setState(() {
            isLoading = false;
          });
        });
      });
    }
    on Exception catch(e){
      print('hello'+e.toString());
    }

  }

  @override
  void initState() {

    getNewsByQuery("Top News");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 20,),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,4),
                    child: Text("Welcome Back!!",
                      style: TextStyle(
                        fontFamily: 'Source Serif 4',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1e293b),
                      ),),
                  ),
                  subtitle: Text("Explore The World with One Click",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748b),
                    ),),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                    // controller: userNameController,
                    // onSubmitted: (value) {
                    //   fetchUserInfo();
                    //   // Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen()));
                    // },

                    style: TextStyle(color: Color(0xFF4c4ddc)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xdacdcfe0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search News",
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

                SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(categoryItem.length, (index) {


                        return GestureDetector(
                          onTap: () {
                            getNewsByQuery(lispath[index]);
                            selectedCategoryIndex=index;// call api on each cli
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: selectedCategoryIndex==index ? Color(0xff4c4ddc) : Color(0xff0f172a)),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(categoryItem[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: selectedCategoryIndex==index ? Colors.white : Colors.white,
                              ),),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                // carousel
                // CarouselSlider(
                //     items: items,
                //     options: CarouselOptions(
                //       height: 250,
                //
                //     ))



                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(newsModelList.length, (index) {
                      return GestureDetector(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,15),
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
                                  padding: const EdgeInsets.fromLTRB(5, 6.5,0,6.5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(newsModelList[index].newsImg,
                                      height: 150,
                                      width: 130,
                                      fit: BoxFit.cover,),
                                  ),
                                ),

                                SizedBox(width: 20,),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5,4,5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width: 200,
                                          child: Text(newsModelList[index].newsHead,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff0f172a),
                                            ),),
                                        ),
                                      ),

                                      SizedBox(height: 10,),

                                      SizedBox(
                                        width: 200,
                                        child: Text("Posted By: " + newsModelList[index].newsPostedBy,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff64748b),
                                          ),),
                                      ),

                                      SizedBox(height: 8,),

                                      SizedBox(
                                        width: 200,
                                        child: Text("Posted On: " + newsModelList[index].newsPostedOn,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff64748b),
                                          ),),
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
}