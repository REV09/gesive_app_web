import 'package:flutter/material.dart';

class ElementCard extends StatelessWidget {
  final Color? color;
  final Color? shadowColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Widget? child;

  const ElementCard({
    Key? key,
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shadowColor: shadowColor,
      elevation: elevation,
      shape: shape,
      child: child,
    );
  }
}
