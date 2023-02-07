import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  const CustomContainer({super.key, this.child, this.width, this.height, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF144771),
            Color(0xFF071A2C),
          ],
        ),
      ),
      child: child,
    );
  }
}
