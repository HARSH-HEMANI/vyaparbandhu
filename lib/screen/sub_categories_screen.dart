import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Biscuits & Cookies', 'icon': Icons.cookie_outlined},
    {'name': 'Chips & Namkeen', 'icon': Icons.fastfood_outlined},
    {'name': 'Beverages & Juices', 'icon': Icons.local_drink_outlined},
    {'name': 'Chocolates & Candies', 'icon': Icons.cake_outlined},
    {'name': 'Noodles & Pasta', 'icon': Icons.ramen_dining_outlined},
    {'name': 'Sauces & Ketchup', 'icon': Icons.liquor_outlined},
    {'name': 'Tea & Coffee', 'icon': Icons.coffee_outlined},
    {'name': 'Pickles & Chutney', 'icon': Icons.shopping_bag_outlined},
    {'name': 'Breakfast Cereals', 'icon': Icons.breakfast_dining_outlined},
    {'name': 'Instant Mixes', 'icon': Icons.menu_book_outlined},
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showMessage(String categoryName) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$categoryName selected')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        toolbarHeight: 64,
        title: const Text(
          'Biscuits, Drinks &\nPacked Food',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
            height: 1.15,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.paddingMedium,
              AppSizes.paddingLarge,
              AppSizes.paddingMedium,
              AppSizes.paddingSmall,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SubCategories',
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: AppSizes.mediumText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingSmall),
                  const Text(
                    'Explore premium selections of packed food and\ndrinks.',
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: AppSizes.extraSmallText,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingMedium,
                AppSizes.paddingMedium,
                AppSizes.paddingMedium,
                AppSizes.paddingLarge,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryTile(_categories[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        isOwner: false,
      ),
    );
  }

  Widget _buildCategoryTile(Map<String, dynamic> category) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: AppSizes.spacingSmall),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _showMessage(category['name'] as String);
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: Icon(
                    category['icon'] as IconData,
                    size: AppSizes.iconMedium,
                    color: AppColors.primaryTextColor,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: Text(
                  category['name'] as String,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.bodyText,
                    fontWeight: FontWeight.w500,
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
