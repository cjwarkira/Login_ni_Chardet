import 'package:flutter/material.dart';
import '../widgets/social_login_button.dart';
import '../constants/app_constants.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onFacebookPressed;
  final String dividerText;

  const SocialLoginSection({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onFacebookPressed,
    this.dividerText = 'Or login with',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with text
        Row(
          children: [
            Expanded(
              child: Container(height: 1, color: AppConstants.hintTextColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(dividerText, style: AppConstants.dividerTextStyle),
            ),
            Expanded(
              child: Container(height: 1, color: AppConstants.hintTextColor),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.sectionSpacing),

        // Social Login Buttons
        Row(
          children: [
            Expanded(
              child: SocialLoginButton(
                icon: Icons.g_mobiledata,
                onPressed: onGooglePressed,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SocialLoginButton(
                icon: Icons.apple,
                onPressed: onApplePressed,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SocialLoginButton(
                icon: Icons.facebook,
                onPressed: onFacebookPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
