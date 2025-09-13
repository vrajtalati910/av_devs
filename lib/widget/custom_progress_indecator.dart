import 'package:av_devs/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomProgressIndecator extends StatelessWidget {
  const CustomProgressIndecator({
    super.key,
    this.color,
    this.strokeWidth = 4.0,
    this.value,
    this.size,
  });
  final Color? color;
  final double strokeWidth;
  final double? value;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
        strokeWidth: strokeWidth,
        value: value,
      ),
    );
  }
}
