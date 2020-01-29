import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_helper/models/user.dart';
import "package:flutter/material.dart";
import 'package:disaster_helper/constants.dart';
import 'package:disaster_helper/widgets/clipper_curve.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import "package:image_picker/image_picker.dart" as img;
import 'package:location/location.dart';

class ReportPage extends StatefulWidget {
  String type;
  ReportPage(this.type);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  File _img;
  String url;
  String desc;
  String title;
  String photo;
  bool loading = false;

  InputDecoration _inputStyle(String label) {
    return new InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      labelText: label,
      alignLabelWithHint: true,
      fillColor: Colors.white,
      border: InputBorder.none,
    );
  }

  Padding _shadowInput(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }

  Future<String> _uploadImage(String imagePath) async {
    CloudinaryClient client = new CloudinaryClient(
        "213825381455339", "48kTGxfznMYqLzZJaXTU2BPOyU4", "dua9p7o7k");
    var response = await client.uploadImage(imagePath);
    return response.url;
  }

  Future<void> _submit() async {
    setState(() {
      this.loading = true;
    });
    var lo = (await Location().getLocation());
    var data = {
      "title": this.title,
      "description": this.desc,
      "photo": await this._uploadImage(this._img.path),
      "location": {
        "lat": lo.latitude,
        "lng": lo.longitude,
      },
      "helped": false,
      "userId": User.USER.id,
    };

    Firestore.instance
        .collection(widget.type == 'news' ? "Report" : "Help")
        .add(data)
        .then((res) {
      Navigator.of(context).pop();
    }).catchError((err) {
      print(err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.YELLOW_LIGHT,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              ClipCurve(
                child: Container(
                  width: double.infinity,
                  color: ColorTheme.PRIMARY,
                  height: MediaQuery.of(context).size.height * .38,
                ),
              ),
              this.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Positioned(
                      top: MediaQuery.of(context).size.height * .2,
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorTheme.BROWN_DARK),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    widget.type == 'news'
                                        ? "แจ้งข่าวสาร"
                                        : "ขอความช่วยเหลือ",
                                    style: TextStyle(
                                        color: ColorTheme.BROWN_DARK,
                                        fontSize: 30),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      this._shadowInput(
                                        TextField(
                                          onChanged: (value) {
                                            this.title = value;
                                          },
                                          decoration:
                                              this._inputStyle("หัวเรื่อง"),
                                        ),
                                      ),
                                      this._shadowInput(
                                        TextField(
                                          minLines: 6,
                                          maxLines: 10,
                                          decoration:
                                              this._inputStyle("เนื้อหา"),
                                          onChanged: (value) {
                                            this.desc = value;
                                          },
                                        ),
                                      ),
                                      this._img == null
                                          ? FlatButton(
                                              color: ColorTheme.BROWN,
                                              child: Text(
                                                "upload รูป",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                img.ImagePicker.pickImage(
                                                  source:
                                                      img.ImageSource.gallery,
                                                ).then((res) async {
                                                  setState(() {
                                                    this._img = res;
                                                  });
                                                  var url = await this
                                                      ._uploadImage(res.path);
                                                  this.url = url;
                                                });
                                              },
                                            )
                                          : Image.file(
                                              this._img,
                                              height: 100,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      RaisedButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "ยกเลิก",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      RaisedButton(
                                        color: ColorTheme.PRIMARY,
                                        onPressed: () {
                                          this._submit();
                                        },
                                        child: Text(
                                          "ยืนยัน",
                                          style: TextStyle(
                                            color: ColorTheme.BROWN_DARK,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
