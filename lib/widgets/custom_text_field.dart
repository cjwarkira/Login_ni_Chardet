import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppConstants.labelTextStyle),
          const SizedBox(height: AppConstants.smallSpacing),
          Container(
            height: 56, // Fixed height to prevent layout shifts
            decoration: BoxDecoration(
              color: AppConstants.textFieldColor,
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(color: AppConstants.whiteColor, width: 1.0),
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              validator: validator,
              style: AppConstants.inputTextStyle,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppConstants.hintTextStyle,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                suffixIcon: suffixIcon,
                errorStyle: const TextStyle(
                  fontSize: 0, // Hide built-in error text
                  height: 0,
                ),
                errorMaxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
