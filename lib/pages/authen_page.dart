import 'package:disaster_helper/models/user.dart';
import 'package:disaster_helper/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AuthenPage extends StatefulWidget {
  @override
  _AuthenPageState createState() => _AuthenPageState();
}

class _AuthenPageState extends State<AuthenPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue[300],
      appBar: AppbarME("LOGIN"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Center(
            child: Text(
              "เข้าสู่ระบบ / สมัครสมาชิก",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Form(
                  key: this._formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onSaved: (String value) {
                          this._username = value;
                        },
                        validator: (String value) {
                          if (value == "") {
                            return "username is not empty";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Username",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (String value) {
                          this._password = value;
                          if (value == "") {
                            return "password is not empty";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () async {
                          User user = new User();
                          if (this._formKey.currentState.validate()) {
                            this._formKey.currentState.save();
                            bool isPass = await user.login(
                                this._username, this._password);

                            if (isPass) {
                              Navigator.of(context)
                                  .pushReplacementNamed("/map");
                            }
                          }
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: Center(
                          child: Text(
                            "เข้าสู่ระบบ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
