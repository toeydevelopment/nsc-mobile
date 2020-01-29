import 'package:disaster_helper/constants.dart';
import 'package:disaster_helper/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget _buildCard(String title, String engTitle, String img) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/signup/$img");
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/imgs/$img.png"),
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 40, letterSpacing: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  engTitle,
                  style: TextStyle(fontSize: 35, letterSpacing: 2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.PRIMARY,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("สมัครสมาชิก",style: TextStyle(
            fontSize: 40,
            letterSpacing: 2,
            color: ColorTheme.BROWN_DARK
          ),),
          this._buildCard("ผู้ประสบภัย", "Victim", "victim"),
          this._buildCard("อาสาสมัคร ", "Volunteer", "volunteer"),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
