import 'dart:convert';

import 'package:disaster_helper/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ERole { VOLUNTEER, VICTIM, GENERAL }
enum ESex {
  FEMALE,
}

class User {
  static User USER;
  static String TOKEN;
  ERole role;
  String username;
  String email;
  int pid;
  String telephone;
  String andress;
  ESex sex;
  String token;

  PublishSubject<bool> isLogin = PublishSubject<bool>();

  Future<bool> login(String username, String password) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    http.Response response = await http.post(
      API + "/",
      body: {
        "username": username,
        "password": password,
      },
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 201) {
      isLogin.add(false);
      return false;
    }

    Map<String, dynamic> _bodyDecoded = jsonDecode(response.body);

    this.username = username;
    this.pid = _bodyDecoded['pid'];
    this.andress = _bodyDecoded['address'];
    this.email = _bodyDecoded['email'];
    this.role = _bodyDecoded['role'];
    this.token = _bodyDecoded['token'];
    this.sex = _bodyDecoded['sex'];
    this.telephone = _bodyDecoded['telephone'];

    Map<String, String> _data = this.toJSON();

    User.USER = this;

    await _pref.setString("credential", jsonEncode(_data));
    await _pref.setString("token", this.token);

    isLogin.add(true);

    return true;
  }

  Future<bool> initUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    dynamic credential = await _pref.getString("credential");

    if (credential == null) {
      isLogin.add(false);
      return false;
    }

    Map<String, dynamic> _bodyDecoded = jsonDecode(credential);

    this.username = username;
    this.pid = _bodyDecoded['pid'];
    this.andress = _bodyDecoded['address'];
    this.email = _bodyDecoded['email'];
    this.role = _bodyDecoded['role'];
    this.sex = _bodyDecoded['sex'];
    this.telephone = _bodyDecoded['telephone'];
    this.token = await _pref.getString("token");

    User.USER = this;
    User.TOKEN = this.token;
    isLogin.add(true);

    return true;
  }

  Future<void> logout() async {
    User.TOKEN = null;
    User.USER = null;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.remove("credential");
    _pref.remove("token");
  }

  Map<String, dynamic> toJSON() {
    return {
      "username": this.username,
      "email": this.email,
      "pid": this.pid,
      "telephone": this.telephone,
      "sex": this.sex,
      "role": this.role
    };
  }
}
