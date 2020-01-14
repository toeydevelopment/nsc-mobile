import 'package:disaster_helper/constants.dart';
import 'package:disaster_helper/models/map.dart';
import 'package:disaster_helper/utils/firestore.dart';
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
  double zoom = 8.0;
  List<Color> colors = <Color>[
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];

  @override
  void initState() {
    getPolygons().then((List<MapModel> maps) {
      maps.forEach((MapModel map) {
        this._add(map);
        mapsModel.add(map);
      });
    });
    widget.latLng.listen((LatLng newLatLng) {
      this.controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: newLatLng, zoom: 15)));
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

  void _add(MapModel map) {
    final String polygonIdVal = 'polygon_id_${map.name}';
    _polygonIdCounter++;
    final PolygonId polygonId = PolygonId(polygonIdVal);
    final Polygon polygon = Polygon(
      polygonId: polygonId,
      consumeTapEvents: true,
      strokeColor: Colors.black,
      strokeWidth: 2,
      fillColor: map.type == "ไฟไหม้"
          ? Color(0xFFE57373).withOpacity(.2)
          : map.type == "น้ำท่วม"
              ? Color(0xFF90CAF9).withOpacity(.2)
              : Color(0xFFA1887F).withOpacity(.2),
      points: _createPoints(map.polygons),
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
      },
      initialCameraPosition: CameraPosition(
        target: this.currentLatLng,
        zoom: zoom,
      ),
      polygons: Set<Polygon>.of(polygons.values),
      onMapCreated: _onMapCreated,
    );
  }

  List<LatLng> _createPoints(List<Map<String, dynamic>> pointsPure) {
    final List<LatLng> points = <LatLng>[];
    pointsPure.forEach((p) {
      points.add(_createLatLng(p['lat'], p['lng']));
    });
    return points;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
}
