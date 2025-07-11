import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final List<BoxShadow>? boxShadow;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? AppConstants.buttonHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: boxShadow ?? AppConstants.defaultBoxShadow,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        child: Text(
          text,
          style: AppConstants.buttonTextStyle.copyWith(
            color: textColor ?? AppConstants.whiteColor,
          ),
        ),
      ),
    );
  }
}
