import 'package:disaster_helper/constants.dart';
import 'package:disaster_helper/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ScaffoldTheme extends StatelessWidget {
  AppbarME appbarME;
  Widget body;

  ScaffoldTheme(this.appbarME, this.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: this.appbarME,
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .2,
              color: ColorTheme.PRIMARY,
            ),
            this.body
          ],
        ));
  }
}
