import 'dart:math';

import 'package:dektodo/const.dart';
import 'package:flutter/material.dart';

class Xian3dButton extends StatelessWidget {
  final double size;
  final Widget childWidget;
  const Xian3dButton({required this.size, required this.childWidget, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        width: size,
        height: size,
        decoration: ShapeDecoration(
          shape: _shape,
          shadows: [
            BoxShadow(color: Colors.white),
            BoxShadow(
              color: primaryColorShadow,
              offset: Offset(0, 20),
              blurRadius: 5,
              spreadRadius: 10,
            ),
            BoxShadow(
              color: primaryColor,
              blurRadius: 10,
              spreadRadius: -2,
            ),
          ],
        ),
        child: childWidget,
      ),
    );
  }
}

ShapeBorder _shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.0),
);

Path myCustomShapePath(Rect rect) {
  var r1 = rect.height * 0.5;
  var r2 = rect.height * 0.35;
  var L = rect.left;
  var R = rect.right;
  var T = rect.top;
  var B = rect.bottom;

  return Path()
    ..moveTo(L, T + r2)
    ..arcTo(Rect.fromLTWH(L, T, r2, r2), pi, 0.5 * pi, false)
    ..lineTo(R - r2, T)
    ..arcTo(Rect.fromLTWH(R - r2, T, r2, r2), 1.5 * pi, 0.5 * pi, false)
    ..lineTo(R, B - r2)
    ..arcTo(Rect.fromLTWH(R - r2, B - r2, r2, r2), 0, 0.5 * pi, false)
    ..lineTo(R - r2, B)
    ..arcTo(Rect.fromLTWH(L, B - r2, r2, r2), 0.5 * pi, 0.5 * pi, false)
    ..close();
  // return Path()
  //   ..moveTo(L, T + r2)
  //   ..arcTo(Rect.fromLTWH(L, T, r2, r2), pi, 0.5 * pi, false)
  //   ..lineTo(R - r2, T)
  //   ..arcTo(Rect.fromLTWH(R - r2, T, r2, r2), 1.5 * pi, 0.5 * pi, false)
  //   ..lineTo(R, B - r1 - 2 * r3)
  //   ..arcTo(Rect.fromLTWH(R - r3, B - r1 - 2 * r3, r3, r3), 0, 0.5 * pi, false)
  //   ..arcTo(Rect.fromLTWH(R - r1 - r3, B - r1 - r3, r1 * 2.5, r1 * 2.5),
  //       1.5 * pi, -0.5 * pi, false)
  //   ..arcTo(Rect.fromLTWH(R - r1 - 2 * r3, B - r3, r3, r3), 0, 0.5 * pi, false)
  //   ..lineTo(R - r2, B)
  //   ..arcTo(Rect.fromLTWH(L, B - r2, r2, r2), 0.5 * pi, 0.5 * pi, false)
  //   ..close();
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) =>
      myCustomShapePath(Rect.fromLTRB(0, 0, size.width, size.height));
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
