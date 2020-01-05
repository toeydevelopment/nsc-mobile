import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/subjects.dart';

class MapWidget extends StatefulWidget {
  LatLng initialLatlng;

  PublishSubject<LatLng> latLng = new PublishSubject<LatLng>();

  MapWidget({this.initialLatlng});

  @override
  State<StatefulWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  MapWidgetState();

  LatLng currentLatLng = new LatLng(15.8700, 100.9925);

  GoogleMapController controller;
  Map<PolygonId, Polygon> polygons = <PolygonId, Polygon>{};
  int _polygonIdCounter = 1;
  PolygonId selectedPolygon;
  int strokeColorsIndex = 0;
  int fillColorsIndex = 0;
  List<Color> colors = <Color>[
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];

  @override
  void initState() {
    widget.latLng.listen((LatLng newLatLng) {
      setState(() {
        this.controller.moveCamera(CameraUpdate.newLatLng(newLatLng));
      });
    });
    if (widget.initialLatlng == null) {
    } else {}
  }

  // Values when toggling polygon width
  int widthsIndex = 0;
  List<int> widths = <int>[10, 20, 5];

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onPolygonTapped(PolygonId polygonId) {
    setState(() {
      selectedPolygon = polygonId;
    });
  }

  void _add() {
    final int polygonCount = polygons.length;

    if (polygonCount == 12) {
      return;
    }

    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygonIdCounter++;
    final PolygonId polygonId = PolygonId(polygonIdVal);

    final Polygon polygon = Polygon(
      polygonId: polygonId,
      consumeTapEvents: true,
      strokeColor: Colors.orange,
      strokeWidth: 5,
      fillColor: Colors.green,
      points: _createPoints(),
      onTap: () {
        _onPolygonTapped(polygonId);
      },
    );

    setState(() {
      polygons[polygonId] = polygon;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.currentLatLng);
    return GoogleMap(
      mapToolbarEnabled: true,
      buildingsEnabled: false,
      trafficEnabled: true,
      compassEnabled: true,
      mapType: MapType.hybrid,
      myLocationEnabled: true,
      onCameraMove: (_) {
        // this.controller.moveCamera(CameraUpdate.newLatLng(this.currentLatLng));
        print("CAMERA MOVING");
      },
      initialCameraPosition: CameraPosition(
        target: this.currentLatLng,
        zoom: 15.0,
      ),
      polygons: Set<Polygon>.of(polygons.values),
      onMapCreated: _onMapCreated,
    );
  }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    final double offset = _polygonIdCounter.ceilToDouble();
    points.add(_createLatLng(51.2395 + offset, -3.4314));
    points.add(_createLatLng(53.5234 + offset, -3.5314));
    points.add(_createLatLng(52.4351 + offset, -4.5235));
    points.add(_createLatLng(52.1231 + offset, -5.0829));
    return points;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
}
