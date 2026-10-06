import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class OwnerProfileScreen extends StatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  State<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends State<OwnerProfileScreen> {
  final int _currentIndex = 3;

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/owner-home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/order-history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/vendor-list');
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: AppSizes.iconMedium,
          ),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: AppSizes.spacingExtraLarge),
              _buildProfileOption(
                icon: Icons.store_outlined,
                title: 'Shop Information',
                onTap: () {},
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              _buildProfileOption(
                icon: Icons.person_outline,
                title: 'Owner Profile',
                onTap: () {},
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              _buildProfileOption(
                icon: Icons.info_outline,
                title: 'About VyaparBandhu',
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              _buildProfileOption(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  Navigator.pushNamed(context, '/help-support');
                },
              ),
              const SizedBox(height: AppSizes.spacingLarge),
              _buildLogoutOption(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        isOwner: true,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.inputBackgroundColor,
            border: Border.all(color: AppColors.borderColor),
          ),
          child: ClipOval(
            child: Image.network(
              AppImages.placeholder,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.person,
                  size: AppSizes.iconLarge,
                  color: AppColors.secondaryTextColor,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        const Text(
          'SuperMart',
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        const Text(
          'jay@gmail.com',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.smallText,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: AppColors.cardColor,
      elevation: AppSizes.cardElevation,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingMedium,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: AppSizes.iconSmall,
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.bodyText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.secondaryTextColor,
                size: AppSizes.iconMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutOption() {
    return InkWell(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/owner-login',
          (route) => false,
        );
      },
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              color: AppColors.errorColor,
              size: AppSizes.iconSmall,
            ),
            const SizedBox(width: AppSizes.spacingSmall),
            const Text(
              'Log Out',
              style: TextStyle(
                color: AppColors.errorColor,
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
