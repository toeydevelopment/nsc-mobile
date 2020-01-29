import 'package:disaster_helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AlertDialog buildSuccessDialog(BuildContext context, String title) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 5,
    backgroundColor: ColorTheme.PRIMARY.withAlpha(500),
    content: Container(
      height: MediaQuery.of(context).size.height * .2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.checkCircle,
            color: Colors.green,
            size: 80,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "$title  สำเร็จ",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 3,
              color: ColorTheme.GREY_DARK,
            ),
          )
        ],
      ),
    ),
    actions: <Widget>[
      FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.check,
          color: Colors.green,
        ),
      )
    ],
  );
}

AlertDialog buildConfirmTaskDialog(
    BuildContext context, String title, String desc) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 5,
    backgroundColor: ColorTheme.BROWN_DARK,
    title: Text(title,
        style: TextStyle(
          fontSize: 25,
          letterSpacing: 3,
          color: Colors.white,
        )),
    content: Container(
      height: MediaQuery.of(context).size.height * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$desc",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 3,
              color: Colors.grey[300],
            ),
          )
        ],
      ),
    ),
    actions: <Widget>[
      FloatingActionButton(
        backgroundColor: Colors.red.withAlpha(1500),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      FloatingActionButton(
        backgroundColor: ColorTheme.PRIMARY,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      )
    ],
  );
}
