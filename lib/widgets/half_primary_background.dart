import 'package:disaster_helper/constants.dart';
import 'package:flutter/material.dart';

class HalfPrimaryCustomBackground extends StatelessWidget {
  Widget child;
  Key key;

  HalfPrimaryCustomBackground({@required this.child, @required this.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .3,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: ColorTheme.PRIMARY,
            height: MediaQuery.of(context).size.height * .25,
          ),
          Align(alignment: Alignment.bottomCenter, child: this.child)
        ],
      ),
    );
  }
}
