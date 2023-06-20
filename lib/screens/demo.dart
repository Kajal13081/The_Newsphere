// import 'dart:convert';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:news_app/models/model.dart';
// import 'package:news_app/screens/newsView.dart';
// import 'package:news_app/screens/view_search.dart';
//
// class Demo extends StatefulWidget{
//   @override
//   State<Demo> createState() => _DemoState();
// }
//
// class _DemoState extends State<Demo> {
//
//   TextEditingController searchController = new TextEditingController();
//   List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
//   List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];
//
//   List<String> categoryItem = ["Top News" , "India", "World News" , "Technology", "Business", "Sports"];
//   int selectedCategoryIndex = 0;
//
//
//
//
//
//   List<String > lispath=['https://newsapi.org/v2/everything?domains=wsj.com&apiKey=920d527c3d8642eea92327e0e59936ef','https://newsapi.org/v2/top-headlines?country=in&apiKey=920d527c3d8642eea92327e0e59936ef','https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=920d527c3d8642eea92327e0e59936ef','https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=920d527c3d8642eea92327e0e59936ef', 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=920d527c3d8642eea92327e0e59936ef','https://newsapi.org/v2/top-headlines?category=sport&apiKey=920d527c3d8642eea92327e0e59936ef'];
//
//   bool isLoading = true;
//   getNewsByQuery(String query) async {
//     Map element;
//     int i = 0;
//     String url =
//         "https://newsapi.org/v2/everything?q=$query&from=2023-06-10&sortBy=publishedAt&apiKey=9bb7bf6152d147ad8ba14cd0e7452f2f";
//     Response response = await get(Uri.parse(url));
//     Map data = jsonDecode(response.body);
//     setState(() {
//       for (element in data["articles"]) {
//         try {
//           i++;
//
//           NewsQueryModel newsQueryModel = new NewsQueryModel();
//           newsQueryModel = NewsQueryModel.fromMap(element);
//           newsModelList.add(newsQueryModel);
//           setState(() {
//             isLoading = false;
//           });
//
//           if (i == 5) {
//             break;
//           }
//         } catch (e) {
//           print(e);
//         }
//         ;
//       }
//     });
//   }
//
//   getNewsofIndia() async {
//     String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=920d527c3d8642eea92327e0e59936ef";
//     Response response = await get(Uri.parse(url));
//     Map data = jsonDecode(response.body);
//     setState(() {
//       data["articles"].forEach((element) {
//         NewsQueryModel newsQueryModel = new NewsQueryModel();
//         newsQueryModel = NewsQueryModel.fromMap(element);
//         newsModelListCarousel.add(newsQueryModel);
//         setState(() {
//           isLoading = false;
//         });
//
//       });
//     });
//
//
//   }
//
//   @override
//   void initState() {
//
//     getNewsByQuery(lispath[0]);
//     getNewsofIndia();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             width: size.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20,),
//                 ListTile(
//                   title: Padding(
//                     padding: const EdgeInsets.fromLTRB(0,0,0,4),
//                     child: Text("Welcome Back!!",
//                       style: TextStyle(
//                         fontFamily: 'Source Serif 4',
//                         fontSize: 30,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFF1e293b),
//                       ),),
//                   ),
//                   subtitle: Text("Explore The World with One Click",
//                     style: TextStyle(
//                       fontFamily: 'Outfit',
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF64748b),
//                     ),),
//                 ),
//
//                 SizedBox(height: 20,),
//
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                   child: TextField(
//                     onSubmitted: (value) {
//                       if(value == ""){
//                         print("BLANK SEARCH");
//                       }else{
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ViewSearch(Query: value)));
//                       }
//                     },
//                     // controller: userNameController,
//                     // onSubmitted: (value) {
//                     //   fetchUserInfo();
//                     //   // Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen()));
//                     // },
//
//                     style: TextStyle(color: Color(0xFF4c4ddc)),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Color(0xdacdcfe0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                       hintText: "Search News",
//                       prefixIcon: Icon(Icons.search),
//                       prefixIconColor: Color(0xFF64748b),
//                       hintStyle: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xFF64748b),
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 30,),
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: List.generate(categoryItem.length, (index) {
//
//
//                         return GestureDetector(
//                           onTap: () {
//                             getNewsByQuery(lispath[index]);
//                             selectedCategoryIndex=index;// call api on each click
//                           },
//                           child: AnimatedContainer(
//                             duration: Duration(milliseconds: 150),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: selectedCategoryIndex==index ? Color(0xff4c4ddc) : Color(0xff0f172a)),
//                             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                             margin: EdgeInsets.symmetric(horizontal: 6),
//                             child: Text(categoryItem[index],
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: selectedCategoryIndex==index ? Colors.white : Colors.white,
//                               ),),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 10,),
//
//                 // carousel
//
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 15),
//                   child: CarouselSlider(
//                     options: CarouselOptions(
//                         height: 200, autoPlay: true, enlargeCenterPage: true),
//                     items: newsModelListCarousel.map((instance) {
//                       return Builder(builder: (BuildContext context) {
//                         return Container(
//
//                             child : Card(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child : Stack(
//                                     children : [
//                                       ClipRRect(
//                                           borderRadius : BorderRadius.circular(10),
//                                           child : Image.network(instance.newsImg , fit: BoxFit.fitHeight, width: double.infinity,)
//                                       ) ,
//                                       Positioned(
//                                           left: 0,
//                                           right: 0,
//                                           bottom: 0,
//                                           child: Container(
//
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(10),
//                                                 gradient: LinearGradient(
//                                                     colors: [
//                                                       Colors.black12.withOpacity(0),
//                                                       Colors.black
//                                                     ],
//                                                     begin: Alignment.topCenter,
//                                                     end: Alignment.bottomCenter
//                                                 )
//                                             ),
//                                             child : Container(
//                                                 padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 10),
//                                                 child:Container( margin: EdgeInsets.symmetric(horizontal: 10), child: Text(instance.newsHead , style: TextStyle(fontSize: 18 , color: Colors.white , fontWeight: FontWeight.bold),))
//                                             ),
//                                           )
//                                       ),
//                                     ]
//                                 )
//                             )
//                         );
//                       });
//                     }).toList(),
//                   ),
//                 ),
//
//
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: List.generate(newsModelList.length, (index) {
//                       return GestureDetector(
//                         // onTap: () => Navigator.of(context).push(
//                         //   MaterialPageRoute(
//                         //     builder: (context) => NewsView(newsModelList[index]),
//                         //   ),
//                         // ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(0,0,0,15),
//                           child: Container(
//                             width: size.width,
//                             margin: EdgeInsets.symmetric(vertical: 5),
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 color: Color(0xdacdcfe0),
//                                 borderRadius: BorderRadius.circular(12)),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.fromLTRB(5, 6.5,0,6.5),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.network(newsModelList[index].newsImg,
//                                       height: 150,
//                                       width: 130,
//                                       fit: BoxFit.cover,),
//                                   ),
//                                 ),
//
//                                 SizedBox(width: 15,),
//
//                                 Padding(
//                                   padding: const EdgeInsets.fromLTRB(0, 5,0,5),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         child: SizedBox(
//                                           width: 200,
//                                           child: Text(getTruncatedTitle(newsModelList[index].newsHead, 60),
//                                             maxLines: 3,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w700,
//                                               color: Color(0xff0f172a),
//                                             ),),
//                                         ),
//                                       ),
//
//                                       SizedBox(height: 10,),
//
//                                       SizedBox(
//                                         width: 200,
//                                         child: Text("Posted By: " + newsModelList[index].newsPostedBy,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Color(0xff64748b),
//                                           ),),
//                                       ),
//
//                                       SizedBox(height: 8,),
//
//                                       SizedBox(
//                                         width: 200,
//                                         child: Text("Posted On: " + newsModelList[index].newsPostedOn,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Color(0xff64748b),
//                                           ),),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                       );
//                     }),
//                   ),
//                 ),
//               ],
//             ),
//
//           ),
//         ),
//       ),
//     );
//   }
//   String getTruncatedTitle(String actualString, int maxLetters) {
//     return actualString.length > maxLetters
//         ? actualString.substring(0, maxLetters) + "..."
//         : actualString;
//   }
// }