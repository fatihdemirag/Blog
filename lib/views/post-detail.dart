import 'dart:convert';
import 'dart:io';
import 'package:blog/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:blog/models/config.dart';

Map arguments;
class PostDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.share),iconSize: 24,padding: EdgeInsets.only(left: 0, right:0, bottom: 0,top:0), onPressed: (){
            Share.share(arguments['link'], subject: 'Fatih Demirağ - Blog');
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<Post>(
              future: getPost(),
              builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                              width: double.infinity,
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/placeholder.png",
                                image: snapshot.data.image,
                                fit: BoxFit.contain,
                              )
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0,top:16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Html(data:snapshot.data.title,defaultTextStyle: Theme.of(context).textTheme.title),
                            Text(DateFormat("dd.MM.yyyy").format(DateTime.parse(snapshot.data.date)),style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              letterSpacing: 2
                            ),),
                            Divider(),
                            SizedBox(height: 10.0,),
                            Html(
                                data: snapshot.data.contentDetail,
                                useRichText: true,
                                onLinkTap:  (url) {
                                  _launchURL(url);
                                }
                            )
                          ],
                        ),
                      ),

                    ],
                  );
                }else if(snapshot.hasError)
                  Fluttertoast.showToast(msg: "Hata oluştu: ${snapshot.error}",gravity: ToastGravity.BOTTOM);
                return Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child:CircularProgressIndicator()
                  ),
                );
              },
            ),
//             )
          ],
        ),
      ),
    );
  }
}
Future<Post> getPost() async
{
  HttpClient httpClient = new HttpClient();
  IOClient ioClient = new IOClient(httpClient);
  final response=await ioClient.get(url+"posts/"+arguments['id'].toString());
  if(response.statusCode==200)
    return Post.fromJson(json.decode(response.body));
  else
    throw Exception("Veriler getirilirken hata oluştu.Hata kodu ${response.statusCode}");
}
_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Bağlantı açılamadı $url';
  }
}
