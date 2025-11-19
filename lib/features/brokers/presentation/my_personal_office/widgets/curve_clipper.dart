// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const curveHeight = 50;
    final controlPoint = Offset(size.width / 2, 0);
    final endPoint =
        Offset(size.width - (size.width / 8), size.height - (curveHeight / 2));

    final path = Path()
      ..lineTo(0, size.height - (curveHeight / 2))
      ..lineTo(size.width / 8, size.height - (curveHeight / 2))
      ..quadraticBezierTo(
        size.width / 7,
        size.height - (curveHeight / 2),
        size.width / 6,
        size.height - 40,
      )
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..lineTo(size.width, size.height - (curveHeight / 2))
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
