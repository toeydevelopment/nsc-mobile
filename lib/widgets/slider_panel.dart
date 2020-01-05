import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SliderPanel extends StatefulWidget {
  @override
  _SliderPanelState createState() => _SliderPanelState();
}

class _SliderPanelState extends State<SliderPanel> {
  PanelController _panelController = new PanelController();

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
              children: List.generate(
                10,
                (_) => ListTile(
                  leading: Icon(Icons.accessible),
                  subtitle: Text("hey my name is mocking"),
                  title: Text("Hello World"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
