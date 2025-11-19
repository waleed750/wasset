// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const curveHeight = 20;
    final controlPoint = Offset(size.width / 2, size.height + curveHeight);
    final endPoint = Offset(size.width, size.height - curveHeight);

    final path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
