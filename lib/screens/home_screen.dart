import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/background_container.dart';
import '../widgets/animated_welcome_card.dart';
import '../controllers/login_controller.dart';

class HomeScreen extends StatelessWidget {
  final String userEmail;

  const HomeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        backgroundImagePath: 'assets/images/building_estate.jpg',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 40),
                _buildWelcomeMessage(),
                const SizedBox(height: 30),
                _buildQuickActions(),
                const SizedBox(height: 30),
                _buildRecentActivity(),
                const Spacer(),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: AppConstants.titleTextStyle.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 4),
            Text(
              userEmail,
              style: AppConstants.bodyTextStyle.copyWith(fontSize: 14),
            ),
          ],
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: AppConstants.defaultBoxShadow,
          ),
          child: const Icon(
            Icons.person,
            color: AppConstants.whiteColor,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeMessage() {
    return AnimatedWelcomeCard(userEmail: userEmail);
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppConstants.labelTextStyle.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.search,
                title: 'Search Properties',
                subtitle: 'Find your dream home',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                icon: Icons.favorite,
                title: 'Favorites',
                subtitle: 'View saved properties',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.location_on,
                title: 'Near Me',
                subtitle: 'Properties nearby',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                icon: Icons.calculate,
                title: 'Calculator',
                subtitle: 'Mortgage calculator',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConstants.socialButtonColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: AppConstants.defaultBoxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppConstants.primaryColor, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppConstants.labelTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppConstants.hintTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppConstants.labelTextStyle.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppConstants.socialButtonColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            boxShadow: AppConstants.defaultBoxShadow,
          ),
          child: Column(
            children: [
              _buildActivityItem(
                icon: Icons.home,
                title: 'Viewed Modern Apartment',
                time: '2 hours ago',
              ),
              const Divider(color: AppConstants.hintTextColor),
              _buildActivityItem(
                icon: Icons.favorite,
                title: 'Added to Favorites',
                time: '1 day ago',
              ),
              const Divider(color: AppConstants.hintTextColor),
              _buildActivityItem(
                icon: Icons.search,
                title: 'Searched in Downtown',
                time: '3 days ago',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppConstants.primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppConstants.labelTextStyle.copyWith(fontSize: 14),
                ),
                Text(
                  time,
                  style: AppConstants.hintTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppConstants.buttonHeight,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: Colors.red.withOpacity(0.3), width: 1),
      ),
      child: ElevatedButton(
        onPressed: () => _handleLogout(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout, color: Colors.red, size: 20),
            const SizedBox(width: 8),
            Text(
              'Logout',
              style: AppConstants.buttonTextStyle.copyWith(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppConstants.socialButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          title: Text('Logout', style: AppConstants.labelTextStyle),
          content: Text(
            'Are you sure you want to logout?',
            style: AppConstants.bodyTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppConstants.linkTextStyle.copyWith(
                  color: AppConstants.hintTextColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // Perform logout
                try {
                  await LoginController().logout();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed('/login');
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout failed: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text(
                'Logout',
                style: AppConstants.linkTextStyle.copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
