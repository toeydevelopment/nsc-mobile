import 'package:disaster_helper/widgets/appbar.dart';
import 'package:disaster_helper/widgets/drawer.dart';
import 'package:disaster_helper/widgets/map.dart';
import 'package:disaster_helper/widgets/slider_panel.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarME("Disaster Helper"),
      drawer: DrawerME(),
      body: Stack(
        children: <Widget>[MapWidget(), SliderPanel()],
      ),
    );
  }
}
