class NewsQueryModel
{
  late String? newsHead;
  late String? newsDes;
  late String? newsImg;
  late String? newsUrl;
  late String? newsPostedBy;
  late DateTime? newsPostedOn;

  NewsQueryModel({
    this.newsHead = "NEWS HEADLINE" ,
    this.newsDes = "SOME NEWS" ,
    this.newsImg = "SOME URL" ,
    this.newsUrl = "SOME URL",
    this.newsPostedBy = "POSTED BY",
    this.newsPostedOn

  });

  factory NewsQueryModel.fromMap(Map news)
  {
    return NewsQueryModel(
        newsHead: news["title"],
        newsDes: news["description"],
        newsImg: news["urlToImage"],
        newsUrl: news["url"],
        newsPostedBy: news["author"],
        newsPostedOn: DateTime.parse(news['publishedAt'])
    );
  }
}