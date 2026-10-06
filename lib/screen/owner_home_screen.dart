import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Browse Products', 'icon': Icons.inventory_2_outlined},
    {'title': 'View Vendors', 'icon': Icons.store_outlined},
    {'title': 'View Orders', 'icon': Icons.receipt_long_outlined},
    {'title': 'View Customers', 'icon': Icons.people_outline},
    {'title': 'View Vendor Orders', 'icon': Icons.local_shipping_outlined},
    {'title': 'Owner Information', 'icon': Icons.person_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: AppSizes.spacingLarge),
                    _buildMenuGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        isOwner: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingLarge,
        AppSizes.paddingMedium,
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSizes.radiusExtraLarge),
          bottomRight: Radius.circular(AppSizes.radiusExtraLarge),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
            ),
            child: ClipOval(
              child: Image.asset(
                AppImages.logo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.store, color: AppColors.primaryColor);
                },
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingMedium),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Jay',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppSizes.headingText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Manage your shop with ease',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: AppSizes.inputHeight,
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search products, brands or categories',
          hintStyle: TextStyle(
            color: AppColors.hintTextColor,
            fontSize: AppSizes.bodyText,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.secondaryTextColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.spacingMedium,
        mainAxisSpacing: AppSizes.spacingMedium,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];

        return _buildMenuCard(title: item['title'], icon: item['icon']);
      },
    );
  }

  Widget _buildMenuCard({required String title, required IconData icon}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: AppSizes.iconLarge,
              ),
            ),
            const SizedBox(height: AppSizes.spacingMedium),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
