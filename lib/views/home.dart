import 'dart:convert';
import 'dart:io';

import 'package:blog/models/category.dart';
import 'package:blog/models/config.dart';
import 'package:blog/models/post.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          _buildSlider(),
          SizedBox(height: 10.0),
          _category(),
          _buildHeading("Son Yazılarım"),
          _buildPost(),
          _buildHeading("Projelerim"),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin:  EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("https://spexa.net/assets/img/projects/crm.png"), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade200,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin:  EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("https://spexa.net/assets/img/projects/gelberber-1.png"), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade200,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin:  EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("https://spexa.net/assets/img/projects/turuncumobilya.png"), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin:  EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("https://spexa.net/assets/img/projects/matematikalistirmalar.jpg"), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade200,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin:  EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("https://fatihdemirag.net/wp-content/uploads/2020/05/mb-1.png"), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade200,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin:  EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("https://fatihdemirag.net/wp-content/uploads/2020/05/IMG_20200501_184735.jpg"), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPost() {
    return FutureBuilder<List<Post>>(
        future: getPost(),
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            return
              ListView.builder(
                  shrinkWrap: true,
                  physics: PageScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {

                    if(index>4)
                    {
                      Post itemPost = snapshot.data[index];
                      return
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/post-detail",arguments: {"id":itemPost.id,"link":itemPost.link});
                          },
                          child:
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 120,
                                  width: 100,
                                  margin: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(itemPost.image), fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Html(data:itemPost.title,defaultTextStyle: TextStyle(fontWeight: FontWeight.bold)),
                                      Html(data:itemPost.content.length>150?itemPost.content.substring(0,180)+"[...]":itemPost.content,useRichText: true)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                    }
                    else
                      return Container();
                  });
          }
          else if(snapshot.hasError)
            Fluttertoast.showToast(msg: "Hata oluştu: ${snapshot.error}",gravity: ToastGravity.BOTTOM);
          return CircularProgressIndicator();
        }
    );
  }

  Padding _buildHeading(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom:15.0,top:15.0,left: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildSlider() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<Post>>(
            future: getPostSlider(),
            builder: (context,snapshot)
            {
              if(snapshot.hasData)
              {
                return CarouselSlider(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  initialPage: 0,
                  reverse: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  items: snapshot.data.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(i.image, fit: BoxFit.cover, width: 1000.0),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      child: Html(
                                        backgroundColor: Colors.white,
                                        data:i.title,
                                        useRichText: true,
                                        defaultTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap:(){
                            Navigator.pushNamed(context, "/post-detail",arguments: {"id":i.id});
                          },
                        );
                      },
                    );
                  }).toList(),
                );

              }
              else if(snapshot.hasError)
                Fluttertoast.showToast(msg: "Hata oluştu: ${snapshot.error}",gravity: ToastGravity.BOTTOM);
              return CircularProgressIndicator();

            }
        )
    );
  }

  Widget _category()
  {
    return Container(
        height: 80,
        child: FutureBuilder<List<Category>>(
            future: getCategories(),
            builder: (context,snapshot)
            {
              if(snapshot.hasData)
              {
                return ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "/post-category",arguments: {"id":snapshot.data[index].id,"title":snapshot.data[index].title});
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data[index].description), fit: BoxFit.cover),
                                    color: Color(0xFFBDCDDE),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  snapshot.data[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              }
              else if(snapshot.hasError)
                Fluttertoast.showToast(msg: "Hata oluştu: ${snapshot.error}",gravity: ToastGravity.BOTTOM);
              return Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child:CircularProgressIndicator()
                ),
              );
            }
        )
    );
  }
}
Future<List<Category>> getCategories() async
{
  HttpClient httpClient = new HttpClient();
  IOClient ioClient = new IOClient(httpClient);
  final response=await ioClient.get(url+"categories?per_page=30");
  if(response.statusCode==200)
  {
    var categories=List<Category>();
    for(var categoryJson in json.decode(response.body))
    {
      categories.add(Category.fromJson(categoryJson));
    }
    return categories;
  }
  else
    throw Exception("Veriler getirilirken hata oluştu");
}
Future<List<Post>> getPost() async
{
  HttpClient httpClient = new HttpClient();
  IOClient ioClient = new IOClient(httpClient);
  final response=await ioClient.get(url+"posts?per_page=15");
  if(response.statusCode==200)
  {
    var posts=List<Post>();
    for(var postJson in json.decode(utf8.decode(response.bodyBytes)))
    {
      posts.add(Post.fromJson(postJson));
    }
    return posts;
  }
  else
    throw Exception("Veriler getirilirken hata oluştu");
}
Future<List<Post>> getPostSlider() async
{
  HttpClient httpClient = new HttpClient();
  IOClient ioClient = new IOClient(httpClient);

  final response=await ioClient.get(url+"posts?per_page=5");
  if(response.statusCode==200)
  {
    var posts=List<Post>();
    for(var postJson in json.decode(utf8.decode(response.bodyBytes)))
    {
      posts.add(Post.fromJson(postJson));
    }
    return posts;
  }
  else
    throw Exception("Veriler getirilirken hata oluştu");
}
