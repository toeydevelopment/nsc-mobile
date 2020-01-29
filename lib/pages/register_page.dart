import 'package:disaster_helper/constants.dart';
import 'package:disaster_helper/models/user.dart';
import 'package:disaster_helper/widgets/appbar.dart';
import 'package:disaster_helper/widgets/half_primary_background.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

class RegisterPage extends StatefulWidget {
  String type;
  RegisterPage({@required this.type})
      : assert(type == "volunteer" || type == "victim");
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  InputDecoration _inputStyle(String label) {
    return new InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      labelText: label,
      fillColor: Colors.white,
      border: InputBorder.none,
    );
  }

  String fname;
  String lname;
  String email;
  String citizen;
  String password;
  String gender;
  String tel;
  String address;
  bool loading = false;

  Padding _shadowInput(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }

  Text _buildHeadline(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        letterSpacing: 5,
        color: ColorTheme.BROWN,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void handleSubmit(BuildContext context) async {
    String token = await FirebaseMessaging().getToken();
    setState(() {
      loading = true;
    });
    fs.Firestore.instance.collection("User").add({
      "fname": fname,
      "lname": lname,
      "email": email,
      "citizen": citizen,
      "password": password,
      "gender": gender,
      "tel": tel,
      "type": widget.type,
      "token": token,
      "address": address
    }).then((_) {
      User().login(
        context,
        fname,
        lname,
        email,
        tel,
        password,
        gender,
        citizen,
        widget.type,
        _.documentID,
      );
    });
  }

  void handleChange(String value, String name) {
    switch (name) {
      case "fname":
        setState(() {
          fname = value;
        });
        break;
      case "lname":
        setState(() {
          lname = value;
        });
        break;
      case "tel":
        setState(() {
          tel = value;
        });
        break;
      case "email":
        setState(() {
          email = value;
        });
        break;
      case "gender":
        setState(() {
          gender = value;
        });
        break;
      case "citizen":
        setState(() {
          citizen = value;
        });
        break;
      case "password":
        setState(() {
          password = value;
        });
        break;
      case "address":
        setState(() {
          address = value;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.YELLOW_LIGHT,
      appBar: AppbarME(
        "สมัคร " + widget.type == 'volunteer' ? 'volunteer' : 'victim',
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            HalfPrimaryCustomBackground(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 10),
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/imgs/" + widget.type + ".png",
                      ),
                      alignment: Alignment.bottomLeft),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      text: widget.type.toUpperCase(),
                      style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 5,
                          color: ColorTheme.BROWN,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            this._buildHeadline("ข้อมูลทั่วไป"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  this._shadowInput(
                    TextField(
                      onChanged: (String value) {
                        this.handleChange(value, "fname");
                      },
                      decoration: this._inputStyle("ชื่อ"),
                    ),
                  ),
                  this._shadowInput(
                    TextField(
                      onChanged: (String value) {
                        this.handleChange(value, "lname");
                        ;
                      },
                      decoration: this._inputStyle("นามสกุล"),
                    ),
                  ),
                  this._shadowInput(
                    TextField(
                      onChanged: (String value) {
                        this.handleChange(value, "email");
                      },
                      decoration: this._inputStyle("email"),
                    ),
                  ),
                  this._shadowInput(
                    TextField(
                      onChanged: (String value) {
                        this.handleChange(value, "citizen");
                      },
                      decoration: this._inputStyle("เลขบัตรประชาชน"),
                    ),
                  ),
                  this._shadowInput(
                    TextField(
                      onChanged: (String value) {
                        this.handleChange(value, "gender");
                      },
                      decoration: this._inputStyle("เพศ"),
                    ),
                  ),
                  this._shadowInput(
                    TextField(
                      onChanged: (String value) {
                        this.handleChange(value, "tel");
                      },
                      decoration: this._inputStyle("เบอร์โทรศัพท์"),
                    ),
                  ),
                  this._shadowInput(
                    TextField(
                      minLines: 5,
                      maxLines: 8,
                      onChanged: (String value) {
                        this.handleChange(value, "tel");
                      },
                      decoration: this._inputStyle("ที่อยู้ "),
                    ),
                  ),
                  this._shadowInput(
                    TextField(
                      obscureText: true,
                      onChanged: (String value) {
                        this.handleChange(value, "password");
                      },
                      decoration: this._inputStyle("password"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: ColorTheme.PRIMARY.withAlpha(100),
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                  ),
                  this.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: double.infinity,
                          child: RaisedButton(
                            color: ColorTheme.PRIMARY,
                            onPressed: () {
                              this.handleSubmit(context);
                            },
                            child: Text("สมัคร"),
                          ),
                        ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
