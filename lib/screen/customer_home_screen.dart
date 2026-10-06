import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final int currentIndex = 0;

  final List<Map<String, dynamic>> actions = [
    {'title': 'Browse Products', 'icon': Icons.shopping_bag_outlined},
    {'title': 'View Cart', 'icon': Icons.shopping_cart_outlined},
    {'title': 'My Orders', 'icon': Icons.receipt_long_outlined},
    {'title': 'My Profile', 'icon': Icons.person_outline},
  ];

  final List<String> categories = [
    'Biscuits, Drinks &\nPacked Food',
    'Cooking\nEssentials',
    'Personal Care',
    'Beauty',
    'Mom & Baby Care',
    'Home Care',
    'Pooja Needs',
    'Disposables',
  ];

  void _openBrowseProducts() {
    Navigator.pushNamed(context, '/sub-categories');
  }

  void _openCart() {
    // Cart screen will be connected when the customer cart screen is integrated.
  }

  void _openOrders() {
    // Customer order screen will be connected when that screen is integrated.
  }

  void _openProfile() {
    // Customer profile screen will be connected when that screen is integrated.
  }

  void _openCategory(String category) {
    if (category == 'Biscuits, Drinks &\nPacked Food') {
      Navigator.pushNamed(context, '/sub-categories');
    } else {
      Navigator.pushNamed(context, '/product-listing', arguments: category);
    }
  }

  void _onBottomNavTap(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        break;
      case 1:
        _openOrders();
        break;
      case 2:
        _openCart();
        break;
      case 3:
        _openProfile();
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
        titleSpacing: AppSizes.paddingLarge,
        title: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImages.logo,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: AppSizes.iconMedium,
                      color: AppColors.primaryColor,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingMedium),
            Text(
              'Hello, Jay',
              style: TextStyle(
                fontSize: AppSizes.mediumText,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.whiteColor),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(width: AppSizes.paddingSmall),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: AppSizes.spacingLarge),
            _buildActionGrid(),
            const SizedBox(height: AppSizes.spacingLarge),
            Text(
              'Categories',
              style: TextStyle(
                fontSize: AppSizes.headingText,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTextColor,
              ),
            ),
            const SizedBox(height: AppSizes.spacingMedium),
            _buildCategoryGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: AppSizes.inputHeight,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search products, brands or categories',
          hintStyle: TextStyle(
            color: AppColors.hintTextColor,
            fontSize: AppSizes.smallText,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.secondaryTextColor,
            size: AppSizes.iconMedium,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSizes.paddingMedium,
            horizontal: AppSizes.paddingSmall,
          ),
        ),
      ),
    );
  }

  Widget _buildActionGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.spacingMedium,
        mainAxisSpacing: AppSizes.spacingMedium,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (context, index) {
        return _buildActionCard(
          actions[index]['title'] as String,
          actions[index]['icon'] as IconData,
          index,
        );
      },
    );
  }

  Widget _buildActionCard(String title, IconData icon, int index) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            _openBrowseProducts();
            break;
          case 1:
            _openCart();
            break;
          case 2:
            _openOrders();
            break;
          case 3:
            _openProfile();
            break;
        }
      },
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: AppSizes.iconMedium,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSmall),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSizes.smallText,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.spacingMedium,
        mainAxisSpacing: AppSizes.spacingMedium,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        return _buildCategoryCard(categories[index]);
      },
    );
  }

  Widget _buildCategoryCard(String category) {
    return InkWell(
      onTap: () {
        _openCategory(category);
      },
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.cardRadius),
                  topRight: Radius.circular(AppSizes.cardRadius),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    AppImages.placeholder,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.inputBackgroundColor,
                        child: Icon(
                          Icons.image_outlined,
                          size: AppSizes.iconLarge,
                          color: AppColors.hintTextColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingSmall),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      category,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppSizes.smallText,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: AppSizes.iconSmall,
                    color: AppColors.secondaryTextColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
