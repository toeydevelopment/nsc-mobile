import 'dart:async';

import 'package:disaster_helper/constants.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1000), () {
      Navigator.of(context).pushReplacementNamed("/landing");
    });

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/imgs/____4x@2x.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        color: ColorTheme.PRIMARY,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "DISASTER",
                          style: TextStyle(
                            color: ColorTheme.GREY_DARK,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      Container(
                        color: ColorTheme.PRIMARY,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "HELPER",
                          style: TextStyle(
                            color: ColorTheme.BROWN,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: "When disaster strikes your community,\n",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                    text:
                                        "you sit idly by while waiting for emergency response teams to act?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    )),
                                TextSpan(
                                  text:
                                      "\nYou can volunteer to help your community!",
                                )
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
