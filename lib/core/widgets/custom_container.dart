import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {this.width,
      this.height,
      this.backgroundColor = Colors.white,
      this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
      this.margin = EdgeInsets.zero,
      this.padding = EdgeInsets.zero,
      this.hasShadow = true,
      this.shadowOpacity = 0.1,
      this.blurRadius = 2,
      this.offsetdx = 1,
      this.offsetdy = 0,
      this.child,
      this.spreadRadius = 1,
      this.alignment: Alignment.center,
      this.image});

  final double width;
  final double height;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final DecorationImage image;
  final bool hasShadow;
  final double shadowOpacity;
  final double blurRadius;
  final Widget child;
  final double offsetdx;
  final double offsetdy;
  final double spreadRadius;
  final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        image: image,
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(shadowOpacity),
                  spreadRadius: spreadRadius,
                  blurRadius: blurRadius,
                  offset: Offset(offsetdx, offsetdy),
                )
              ]
            : [
                BoxShadow(
                  color: Color(0xffEBEDEF),
                  spreadRadius: 1,
                )
              ],
      ),
      child: child,
    );
  }
}
