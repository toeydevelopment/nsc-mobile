import 'package:flutter/material.dart';

class ClipCurve extends StatelessWidget {
  Widget child;
  Key key;
  ClipCurve({this.child, this.key});
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperCurve(),
      child: this.child,
    );
  }
}

class CustomClipperCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * .7);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * .7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
