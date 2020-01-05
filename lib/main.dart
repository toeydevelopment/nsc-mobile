import 'package:disaster_helper/models/user.dart';
import 'package:disaster_helper/pages/authen_page.dart';
import 'package:disaster_helper/pages/landing_page.dart';
import 'package:disaster_helper/pages/news_detail_page.dart';
import 'package:disaster_helper/pages/news_page.dart';
import 'package:disaster_helper/pages/victims_area_page.dart';
import 'package:disaster_helper/widgets/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    User user = new User();
    user.isLogin.listen((bool loggedIn) {
      this.setState(() {
        this._isLoggedIn = loggedIn;
      });
    });
    user.initUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disaster Helper',
      theme: ThemeData(textTheme: GoogleFonts.promptTextTheme()),
      routes: {
        "/": (BuildContext context) => LandingPage(),
        "/news": (BuildContext context) => NewsPage(),
        "/authen": (BuildContext context) => AuthenPage()
      },
      onGenerateRoute: (RouteSettings settings) {
        List<String> paths = settings.name.split("/");
        print(paths);
        if (paths[1] == "news") {
          return CustomRoute(
              builder: (BuildContext context) => NewsDetailPage(paths[2]));
        }
      },
    );
  }
}
