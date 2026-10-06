import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          _onBottomNavTap(context, index);
        },
      ),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar() {
    return Container(
      height: AppSizes.appBarHeight,
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
              size: AppSizes.iconMedium,
            ),
          ),
          const Expanded(
            child: Text(
              AppStrings.myProfile,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: AppSizes.headingText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONTENT
  // ============================================================

  Widget _buildContent(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingSmall,
        AppSizes.paddingMedium,
        AppSizes.paddingSmall,
        AppSizes.paddingExtraLarge,
      ),
      children: [
        _buildProfileHeader(),

        const SizedBox(
          height: AppSizes.spacingLarge,
        ),

        _buildMenuItems(context),

        const SizedBox(
          height: AppSizes.spacingExtraLarge,
        ),

        _buildLogoutButton(context),
      ],
    );
  }

  // ============================================================
  // PROFILE HEADER
  // ============================================================

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSizes.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
        border: Border.all(
          color: AppColors.borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProfileImage(),

          const SizedBox(
            width: AppSizes.spacingMedium,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'SuperMart',
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.bodyText,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  'jay.email@gmail.com',
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.extraSmallText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: const Icon(
        Icons.person_outline,
        color: AppColors.primaryColor,
        size: AppSizes.iconLarge,
      ),
    );
  }

  // ============================================================
  // MENU ITEMS
  // ============================================================

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _ProfileMenuCard(
          icon: Icons.person_outline,
          title: AppStrings.manageProfile,
          onTap: () {
            _showMessage(
              context,
              AppStrings.manageProfile,
            );
          },
        ),

        const SizedBox(
          height: AppSizes.spacingSmall,
        ),

        _ProfileMenuCard(
          icon: Icons.receipt_long_outlined,
          title: AppStrings.orderHistory,
          onTap: () {
            _showMessage(
              context,
              AppStrings.orderHistory,
            );
          },
        ),

        const SizedBox(
          height: AppSizes.spacingSmall,
        ),

        _ProfileMenuCard(
          icon: Icons.location_on_outlined,
          title: AppStrings.myAddress,
          onTap: () {
            _showMessage(
              context,
              AppStrings.myAddress,
            );
          },
        ),

        const SizedBox(
          height: AppSizes.spacingSmall,
        ),

        _ProfileMenuCard(
          icon: Icons.info_outline,
          title: AppStrings.aboutVyaparBandhu,
          onTap: () {
            _showMessage(
              context,
              AppStrings.aboutVyaparBandhu,
            );
          },
        ),

        const SizedBox(
          height: AppSizes.spacingSmall,
        ),

        _ProfileMenuCard(
          icon: Icons.help_outline,
          title: AppStrings.helpSupport,
          onTap: () {
            _showMessage(
              context,
              AppStrings.helpSupport,
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          _showLogoutDialog(context);
        },
        icon: const Icon(
          Icons.logout,
          color: AppColors.errorColor,
          size: AppSizes.iconSmall,
        ),
        label: const Text(
          AppStrings.logOut,
          style: TextStyle(
            color: AppColors.errorColor,
            fontSize: AppSizes.smallText,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingSmall,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // LOGOUT DIALOG
  // ============================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Log Out',
            style: TextStyle(
              fontSize: AppSizes.headingText,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Logged out successfully',
                      ),
                      duration: Duration(
                        milliseconds: 1200,
                      ),
                      behavior:
                          SnackBarBehavior.floating,
                    ),
                  );
              },
              child: const Text(
                AppStrings.logOut,
                style: TextStyle(
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '$message screen will be connected next.',
          ),
          duration: const Duration(
            milliseconds: 1200,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  void _onBottomNavTap(
    BuildContext context,
    int index,
  ) {
    if (index == 3) {
      return;
    }

    // Other customer navigation screens
    // will be connected with the main navigation flow.
  }
}

// =================================================================
// PROFILE MENU CARD
// =================================================================

class _ProfileMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardColor,
      borderRadius: BorderRadius.circular(
        AppSizes.cardRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSizes.cardRadius,
            ),
            border: Border.all(
              color: AppColors.borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.03,
                ),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.primaryTextColor,
                size: AppSizes.iconSmall,
              ),

              const SizedBox(
                width: AppSizes.spacingMedium,
              ),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.smallText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: AppColors.primaryTextColor,
                size: AppSizes.iconMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}