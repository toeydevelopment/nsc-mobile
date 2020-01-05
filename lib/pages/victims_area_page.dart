import 'package:disaster_helper/widgets/appbar.dart';
import 'package:disaster_helper/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VictimAreaPage extends StatefulWidget {
  @override
  _VictimAreaPageState createState() => _VictimAreaPageState();
}

class _VictimAreaPageState extends State<VictimAreaPage> {
  Widget _buildTile() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * .1,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.addressBook,
              size: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .05,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "title",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Text(
                        "Connected d (n0ignmed: asda asdasda22das as",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.access_alarm),
                    Text(" 12.00 AM"),
                  ],
                ),
                Text("สถานะ: ยังไม่ดำเนินการ")
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarME("ผู้ประสบภัย"),
      drawer: DrawerME(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: List.generate(10, (_) => this._buildTile()),
          ),
        ),
      ),
    );
  }
}
