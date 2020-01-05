import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:disaster_helper/widgets/appbar.dart';
import 'package:disaster_helper/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool _isLoading = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 800), () {
      setState(() {
        this._isLoading = false;
      });
    });
  }

  Widget _buildTapTypeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 3,
          child: Container(
            child: Center(child: Text("น้ำท่วม")),
            width: MediaQuery.of(context).size.width / 4 - 20,
          ),
          onPressed: () {},
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 3,
          child: Container(
            child: Center(child: Text("พายุ")),
            width: MediaQuery.of(context).size.width / 4 - 20,
          ),
          onPressed: () {},
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 3,
          child: Container(
            child: Center(child: Text("แผ่นดินไหว")),
            width: MediaQuery.of(context).size.width / 4 - 20,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFeatureBox() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.red),
          height: MediaQuery.of(context).size.height * .3,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Text("เรื่องเด่น"),
        ),
      ],
    );
  }

  Widget _headTitle(String title) {
    return Text(
      title,
      style: TextStyle(letterSpacing: 2, fontSize: 30),
    );
  }

  Widget _newsTileSkel() {
    return ListTile(
      leading: Container(
          width: 50,
          height: 50,
          child: SkeletonAnimation(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
          )),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .6,
            // height: 20,
            child: SkeletonAnimation(
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                // height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .6,
            // height: 20,
            child: SkeletonAnimation(
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .6,
            // height: 20,
            child: SkeletonAnimation(
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListNews() {
    return Column(
      children: List.generate(
        4,
        (i) => this._isLoading
            ? this._newsTileSkel()
            : ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed("/news/1");
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://pixlr.com/photo/image-design-11-1-pw.jpg",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
                isThreeLine: true,
                title: Text("test"),
                subtitle: Text(
                    "interface: en0 Duration: 62.888s,s took 0.n/out: 1511611/19166, packets in/out: 1186/63, rtt: 0.134s, retransmitted packets: 2, out-of-order packets: 468"),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarME("ข่าวสาร"),
      drawer: DrawerME(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              this._buildTapTypeSection(),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    this._headTitle("เรื่องเด่น"),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: this._buildFeatureBox(),
                    ),
                    this._headTitle("For you"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              this._buildListNews()
            ],
          ),
        ),
      ),
    );
  }
}
