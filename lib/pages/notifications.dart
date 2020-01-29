import 'package:disaster_helper/constants.dart';
import 'package:disaster_helper/widgets/appbar.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Widget _buildTile() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 2,
                spreadRadius: 1)
          ],
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.notifications_active,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2 + 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "รายละเอียด",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "หก ฟกหฟกฟกฟห ฟหกฟหกาสว ฟสกฟหสฟนไๆจ ทสฟหสก",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              height: 60,
              child: Text(
                "1 มีนาคม 2562",
                style: TextStyle(fontSize: 8, color: Colors.grey),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.YELLOW_LIGHT,
      appBar: AppbarME("การแจ้งเตือน"),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: List.generate(
              10,
              (_) => this._buildTile(),
            ),
          ),
        ),
      ),
    );
  }
}
