import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.socialButtonSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppConstants.socialButtonColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: AppConstants.defaultBoxShadow,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor ?? AppConstants.whiteColor,
          size: 18, // Smaller icon size as per Figma design
        ),
      ),
    );
  }
}
