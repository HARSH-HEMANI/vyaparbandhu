import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  static const List<_SubCategory> _subCategories = [
    _SubCategory(title: 'Biscuits & Cookies', icon: Icons.cookie_outlined),
    _SubCategory(title: 'Chips & Namkeen', icon: Icons.fastfood_outlined),
    _SubCategory(title: 'Beverages & Juices', icon: Icons.local_drink_outlined),
    _SubCategory(title: 'Chocolates & Candies', icon: Icons.cake_outlined),
    _SubCategory(title: 'Noodles & Pasta', icon: Icons.ramen_dining_outlined),
    _SubCategory(title: 'Sauces & Ketchup', icon: Icons.liquor_outlined),
    _SubCategory(title: 'Tea & Coffee', icon: Icons.coffee_outlined),
    _SubCategory(title: 'Pickles & Chutney', icon: Icons.shopping_bag_outlined),
    _SubCategory(
      title: 'Breakfast Cereals',
      icon: Icons.breakfast_dining_outlined,
    ),
    _SubCategory(title: 'Instant Mixes', icon: Icons.menu_book_outlined),
  ];

  // ============================================================
  // CUSTOMER NAVIGATION
  // ============================================================

  void _openHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/customer-home',
      (route) => false,
    );
  }

  void _openOrders(BuildContext context) {
    Navigator.pushNamed(context, '/customer-orders');
  }

  void _openCart(BuildContext context) {
    Navigator.pushNamed(context, '/customer-cart');
  }

  void _openProfile(BuildContext context) {
    Navigator.pushNamed(context, '/customer-profile');
  }

  void _openProductListing(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      '/customer-product-listing',
      arguments: category,
    );
  }

  void _onBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        _openHome(context);
        break;

      case 1:
        _openOrders(context);
        break;

      case 2:
        _openCart(context);
        break;

      case 3:
        _openProfile(context);
        break;
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,

        body: Column(
          children: [
            // ==================================================
            // BLUE STATUS BAR + APP BAR
            // ==================================================
            Container(
              width: double.infinity,
              color: AppColors.primaryColor,
              child: SafeArea(bottom: false, child: _buildAppBar(context)),
            ),

            // ==================================================
            // CONTENT
            // ==================================================
            Expanded(child: _buildContent(context)),
          ],
        ),

        // ======================================================
        // BOTTOM NAVIGATION
        // ======================================================
        bottomNavigationBar: BottomNavBar(
          currentIndex: 0,
          onTap: (index) {
            _onBottomNavTap(context, index);
          },
        ),
      ),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar(BuildContext context) {
    return SizedBox(
      height: AppSizes.appBarHeight,
      width: double.infinity,
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

          Expanded(
            child: Text(
              AppStrings.biscuitsDrinksPackagedFood,
              style: const TextStyle(
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
        AppSizes.paddingExtraLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SubCategories',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.headingText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          const Text(
            'Explore premium selections of packed food and drinks.',
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _subCategories.length,
            separatorBuilder: (_, _) {
              return const SizedBox(height: AppSizes.spacingMedium);
            },
            itemBuilder: (context, index) {
              final category = _subCategories[index];

              return _SubCategoryCard(
                category: category,
                onTap: () {
                  _openProductListing(context, category.title);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SUB-CATEGORY CARD
// ============================================================

class _SubCategoryCard extends StatelessWidget {
  final _SubCategory category;
  final VoidCallback onTap;

  const _SubCategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardColor,
      elevation: AppSizes.cardElevation,
      shadowColor: Colors.black.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              _buildIcon(),

              const SizedBox(width: AppSizes.spacingMedium),

              Expanded(
                child: Text(
                  category.title,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.bodyText,
                    fontWeight: FontWeight.w600,
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

  Widget _buildIcon() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Icon(
        category.icon,
        color: AppColors.primaryColor,
        size: AppSizes.iconMedium,
      ),
    );
  }
}

// ============================================================
// SUB-CATEGORY MODEL
// ============================================================

class _SubCategory {
  final String title;
  final IconData icon;

  const _SubCategory({required this.title, required this.icon});
}
