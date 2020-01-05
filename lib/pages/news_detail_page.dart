import 'package:cached_network_image/cached_network_image.dart';
import 'package:disaster_helper/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class NewsDetailPage extends StatelessWidget {

  String newsId;

  NewsDetailPage(this.newsId);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarME("ข่าว"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey[300],
                        offset: Offset(1, 1),
                        spreadRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Column(
                  children: <Widget>[
                    Text(
                      "The German bombing",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        height: 250,
                        width: double.infinity,
                        imageUrl:
                            "https://images.unsplash.com/photo-1499084732479-de2c02d45fcc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
                        fit: BoxFit.cover,
                        fadeInCurve: Curves.bounceInOut,
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          height: 250,
                          child: SkeletonAnimation(
                            child: Container(
                              color: Colors.grey[300],
                              height: 250,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "The Netherlands during the Second World War was The Netherlands during the The Netherlands during the The Netherlands during the The Netherlands during the The Netherlands during the strategically lodged between Great Britain and Germany, making it an ideal prospective German air and naval “base” for any air or sea attack against the British Isles. The Netherlands had firmly opted for neutrality throughout the First World War and had planned to do the same for the Second World War. The German bombing of Rotterdam, also known as the Rotterdam Blitz, was the aerial bombardment of Rotterdam by the Luftwaffe on 14 May 1940, during the German invasion of the Netherlands in World War II. The objective was to support the German troops fighting in the city, break Dutch resistance and force the Dutch army to surrender. Almost the entire historic city centre was destroyed, and nearly 900 people were killed, as well as making 85,000 more homeless.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
