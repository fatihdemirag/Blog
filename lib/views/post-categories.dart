import 'dart:convert';
import 'dart:io';
import 'package:blog/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blog/models/config.dart';
import 'package:http/io_client.dart';

Map arguments;

class PostCategory extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title:Text(arguments['title'].toString(),style: TextStyle(color: Colors.black),),

      ),
      body:SingleChildScrollView(
        child:
        Container(
            child: Column(
              children: <Widget>[
                _buildPost(context)
              ],
            )
        ),
      ),
    );
  }
}

Widget _buildPost(BuildContext context){
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<Post>>(
                future: getPost(),
                builder: (context,snapshot)
                {
                  if(snapshot.hasData)
                  {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Post itemPost = snapshot.data[index];
                          return Column(
                            children: <Widget>[
                              ListTile(
                                  leading:SizedBox(
                                      height: 80.0,
                                      width: 80.0,
                                      child:FadeInImage.assetNetwork(
                                        placeholder: "assets/images/placeholder.png",
                                        image: itemPost.image,
                                        fit: BoxFit.contain,
                                      )
                                  ),
                                  title: Html(data:itemPost.title),
                                  subtitle: Html(data:itemPost.content),
                                  onTap: (){
                                    Navigator.pushNamed(context, "/post-detail",arguments: {"id":itemPost.id,"link":itemPost.link});
                                  }
                              ),
                              Divider(height: 4.0),
                            ],
                          );
                        });
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
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ),
  );
}
Future<List<Post>> getPost() async
{

  HttpClient httpClient = new HttpClient();
  IOClient ioClient = new IOClient(httpClient);
  final response=await ioClient.get(url+"posts/?categories="+arguments['id'].toString());
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
