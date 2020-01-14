import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:disaster_helper/models/map.dart';

Future<List<MapModel>> getPolygons() async {
  var data =
      await fs.Firestore.instance.collection("DisasterArea").getDocuments();
  List<MapModel> maps = [];
  data.documents.forEach((doc) {
    List<Map<String, dynamic>> polygon = [];

    (doc.data['polygons'] as Map).forEach((key, value) {
      polygon.add({
        "lat": value['lat'],
        "lng": value['lng'],
      });
    });
    maps.add(new MapModel(doc.data['name'], doc.data['type'], polygon));
  });
  return maps;
}
