import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
        Navigator.pushReplacementNamed(context, '/owner-profile');
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
          'About',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spacingExtraLarge),
            _buildLogo(),
            const SizedBox(height: AppSizes.spacingLarge),
            const Text(
              'VyaparBandhu',
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.titleText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSmall),
            const Text(
              'Your Business Partner',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: AppSizes.bodyText,
              ),
            ),
            const SizedBox(height: AppSizes.spacingExtraLarge),
            _buildInformationCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        isOwner: true,
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 110,
      height: 110,
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Image.asset(
        AppImages.logo,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.store,
            color: AppColors.primaryColor,
            size: AppSizes.iconLarge,
          );
        },
      ),
    );
  }

  Widget _buildInformationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInformationRow(title: 'Version', value: 'v1.2.4'),
          const Divider(
            height: AppSizes.spacingExtraLarge,
            color: AppColors.borderColor,
          ),
          _buildInformationRow(title: 'Developer', value: 'Vyapar Solution'),
        ],
      ),
    );
  }

  Widget _buildInformationRow({required String title, required String value}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.bodyText,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
