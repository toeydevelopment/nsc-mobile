import 'package:disaster_helper/constants.dart';
import 'package:disaster_helper/models/map.dart';
import 'package:disaster_helper/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SliderPanel extends StatefulWidget {
  MapWidget map;
  SliderPanel(this.map);

  @override
  _SliderPanelState createState() => _SliderPanelState();
}

class _SliderPanelState extends State<SliderPanel> {
  PanelController _panelController = new PanelController();

  List<MapModel> mapSearch = [];
  handleSearch(String search) {
    setState(() {
      this.mapSearch = mapsModel.where((map) {
        return map.name.startsWith(search) || map.type.startsWith(search);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 100,
      controller: this._panelController,
      maxHeight: MediaQuery.of(context).size.height / 2 + 10,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3), blurRadius: 5, spreadRadius: 5)
      ],
      panel: Column(
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  this._panelController.isPanelOpen()
                      ? this._panelController.close()
                      : this._panelController.open();
                },
                child: Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              onChanged: (String value) {
                this.handleSearch(value);
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                suffixIcon: Icon(FontAwesomeIcons.search),
                alignLabelWithHint: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                labelText: 'search something..',
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2 - 100,
            child: ListView(
              children: this
                  .mapSearch
                  .map(
                    (map) => ListTile(
                      leading: Icon(
                        map.type == "ไฟไหม้"
                            ? FontAwesomeIcons.fire
                            : map.type == "น้ำท่วม"
                                ? FontAwesomeIcons.water
                                : Icons.business_center,
                        color: map.type == "ไฟไหม้"
                            ? Colors.redAccent
                            : map.type == "น้ำท่วม"
                                ? Colors.blue
                                : Colors.brown,
                      ),
                      subtitle: Text(map.type),
                      onTap: () {
                        double x = 0;
                        double y = 0;
                        map.polygons.forEach((p) {
                          x += p['lat'];
                          y += p['lng'];
                        });
                        widget.map.latLng.add(
                          new LatLng(
                              x / map.polygons.length, y / map.polygons.length),
                        );
                        this._panelController.close();
                      },
                      title: Text(
                        map.name,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
