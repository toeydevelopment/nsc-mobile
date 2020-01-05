import 'package:flutter/material.dart';

class AppbarME extends StatelessWidget implements PreferredSizeWidget {

  String _title;

  AppbarME(this._title);

  @override
  Size get preferredSize => Size(double.infinity, 50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this._title),
      elevation: 10,
    );
  }
}
