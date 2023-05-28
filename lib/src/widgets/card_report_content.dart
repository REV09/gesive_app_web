import 'package:flutter/material.dart';

class ReportCardContent extends StatelessWidget {
  final BoxConstraints? constraints;
  final Widget? child;

  const ReportCardContent({
    Key? key,
    this.child,
    this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      child: child,
    );
  }
}
