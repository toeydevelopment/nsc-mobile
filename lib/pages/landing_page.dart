import 'package:disaster_helper/widgets/appbar.dart';
import 'package:disaster_helper/widgets/drawer.dart';
import 'package:disaster_helper/widgets/map.dart';
import 'package:disaster_helper/widgets/slider_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingPageSate();
  }
}

class _LandingPageSate extends State<LandingPage> {
  MapWidget map = new MapWidget();

  Future<LocationData> getCurrentLocation() async {
    var location = new Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarME("Disaster Helper"),
      drawer: DrawerME(),
      body: Stack(
        children: <Widget>[
          map,
          Positioned(
            bottom: 120,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () async {
                var lo = await this.getCurrentLocation();

                map.latLng.add(new LatLng(lo.latitude, lo.longitude));
              },
              child: Icon(
                Icons.my_location,
                color: Colors.blue,
              ),
            ),
          ),
          SliderPanel(),
        ],
      ),
    );
  }
}
