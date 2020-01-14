import 'package:cloud_firestore/cloud_firestore.dart' as fs;

Future<void> getPolygons() async {
  var data =
      await fs.Firestore.instance.collection("DisasterArea").getDocuments();

  data.documents.forEach((doc) {
    print(doc);
  });
}
