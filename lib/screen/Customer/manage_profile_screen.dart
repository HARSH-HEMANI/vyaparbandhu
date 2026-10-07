import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController(
    text: 'Jay',
  );

  final TextEditingController _lastNameController = TextEditingController(
    text: 'Sharma',
  );

  final TextEditingController _emailController = TextEditingController(
    text: 'jay.email@gmail.com',
  );

  final TextEditingController _phoneController = TextEditingController(
    text: '+91 xxxxx xxxxx',
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onBottomNavTap(int index) {
    if (index == 3) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/customer-home',
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/customer-orders');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/customer-cart');
        break;
      case 3:
        break;
    }
  }

  void _saveChanges() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          duration: Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: _onBottomNavTap,
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
              size: AppSizes.iconMedium,
            ),
          ),
          const Expanded(
            child: Text(
              'Manage Profile',
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

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingSmall,
        AppSizes.paddingMedium,
        AppSizes.paddingSmall,
        AppSizes.paddingExtraLarge,
      ),
      child: Column(
        children: [
          _buildProfileImage(),

          const SizedBox(height: AppSizes.spacingLarge),

          _buildPersonalDetails(),

          const SizedBox(height: AppSizes.spacingExtraLarge),

          _buildSaveButton(),
        ],
      ),
    );
  }

  // ============================================================
  // PROFILE IMAGE PLACEHOLDER
  // ============================================================

  Widget _buildProfileImage() {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.person_outline,
        color: AppColors.primaryColor,
        size: 38,
      ),
    );
  }

  // ============================================================
  // PERSONAL DETAILS
  // ============================================================

  Widget _buildPersonalDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 2, bottom: AppSizes.spacingMedium),
            child: Text(
              AppStrings.personalDetails,
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'First Name',
                  controller: _firstNameController,
                ),
              ),

              const SizedBox(width: AppSizes.spacingMedium),

              Expanded(
                child: _buildTextField(
                  label: 'Last Name',
                  controller: _lastNameController,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          _buildTextField(
            label: AppStrings.emailAddress,
            controller: _emailController,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          _buildTextField(
            label: 'Phone Number',
            controller: _phoneController,
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    IconData? prefixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.extraSmallText,
          ),
        ),

        const SizedBox(height: 4),

        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.smallText,
            ),
            decoration: InputDecoration(
              prefixIcon: prefixIcon == null
                  ? null
                  : Icon(
                      prefixIcon,
                      size: AppSizes.iconSmall,
                      color: AppColors.secondaryTextColor,
                    ),
              filled: true,
              fillColor: AppColors.inputBackgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall,
                vertical: AppSizes.paddingSmall,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SAVE BUTTON
  // ============================================================

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: _saveChanges,
        icon: const Icon(Icons.check_circle, size: AppSizes.iconSmall),
        label: const Text(
          AppStrings.saveChanges,
          style: TextStyle(
            fontSize: AppSizes.smallText,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
      ),
    );
  }
}
