class Post {
  String content;
  String contentDetail;
  String title;
  String image;
  int id;
  String date;
  String link;

  Post({this.content, this.title, this.image, this.id,this.contentDetail,this.date,this.link});

  factory Post.fromJson(Map<String,dynamic> json)
  {
    return Post(
      title: json['title']['rendered'].toString(),
      id:json["id"],
      image:json["jetpack_featured_media_url"],
      content: json['excerpt']['rendered'].toString(),
      contentDetail: json['content']['rendered'].toString(),
      date: json['date'],
      link: json['link'],
    );
  }
}
