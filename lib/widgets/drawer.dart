import 'dart:io';

import 'package:disaster_helper/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerME extends StatefulWidget {
  @override
  _DrawerMEState createState() => _DrawerMEState();
}

class _DrawerMEState extends State<DrawerME> {
  String _currentPath;

  @override
  void initState() {
    super.initState();
  }

  void handleTap(BuildContext context, String path) {
    if (this._currentPath != path) {
      Navigator.of(context).pushNamed(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    this._currentPath = ModalRoute.of(context).settings.name;
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.all(0),
            child: Container(
              child: Text("TEST"),
              width: double.infinity,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            selected: this._currentPath == "/",
            leading: Icon(FontAwesomeIcons.mapMarked),
            title: Text("แผนที่"),
            onTap: () => handleTap(context, "/"),
          ),
          ListTile(
            selected: this._currentPath == "/news",
            leading: Icon(FontAwesomeIcons.newspaper),
            title: Text("ข่าวสาร"),
            onTap: () => handleTap(context, "/news"),
          ),
          User.TOKEN == null
              ? ListTile(
                  selected: this._currentPath == "/authen",
                  leading: Icon(FontAwesomeIcons.user),
                  title: Text("login"),
                  onTap: () => handleTap(context, "/authen"),
                )
              : ListTile(
                  selected: this._currentPath == "/authen",
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  title: Text("logout"),
                  onTap: () async {
                    await User().logout();
                    exit(0);
                  },
                )
        ],
      ),
    );
  }
}
