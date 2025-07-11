import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AnimatedWelcomeCard extends StatefulWidget {
  final String userEmail;

  const AnimatedWelcomeCard({super.key, required this.userEmail});

  @override
  State<AnimatedWelcomeCard> createState() => _AnimatedWelcomeCardState();
}

class _AnimatedWelcomeCardState extends State<AnimatedWelcomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor.withOpacity(0.2),
                AppConstants.primaryColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(
              color: AppConstants.primaryColor.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: AppConstants.defaultBoxShadow,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: AppConstants.whiteColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: AppConstants.labelTextStyle.copyWith(
                            fontSize: 18,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        Text(
                          'Login Successful',
                          style: AppConstants.bodyTextStyle.copyWith(
                            fontSize: 14,
                            color: AppConstants.whiteColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'You have successfully logged into your Real Estate app as:',
                style: AppConstants.bodyTextStyle.copyWith(
                  fontSize: 14,
                  color: AppConstants.whiteColor.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppConstants.primaryColor.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.userEmail,
                  style: AppConstants.labelTextStyle.copyWith(
                    fontSize: 14,
                    color: AppConstants.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
