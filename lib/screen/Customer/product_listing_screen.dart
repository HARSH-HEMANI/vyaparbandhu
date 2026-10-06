import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() =>
      _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  int _selectedBrandIndex = 0;

  final List<String> _brands = [
    'All',
    'Sunfeast',
    'Britannia',
    'Parle',
  ];

  final List<_Product> _products = const [
    _Product(
      name: 'Parle-G Gold',
      brand: 'Parle',
      price: '₹45',
      mrp: '₹50',
      quantity: '200g',
    ),
    _Product(
      name: 'Good Day',
      brand: 'Britannia',
      price: '₹80',
      mrp: '₹90',
      quantity: '420g',
    ),
    _Product(
      name: 'Oreo Original',
      brand: 'Cadbury',
      price: '₹25',
      mrp: '₹30',
      quantity: '89g',
    ),
    _Product(
      name: 'Dark Fantasy',
      brand: 'Sunfeast',
      price: '₹45',
      mrp: '₹50',
      quantity: '150g',
    ),
    _Product(
      name: 'Hide & Seek',
      brand: 'Parle',
      price: '₹35',
      mrp: '₹40',
      quantity: '120g',
    ),
    _Product(
      name: 'Marie Gold',
      brand: 'Britannia',
      price: '₹30',
      mrp: '₹35',
      quantity: '250g',
    ),
  ];

  void _onBottomNavTap(int index) {
    if (index == 0) {
      Navigator.popUntil(
        context,
        (route) => route.isFirst,
      );
      return;
    }

    // Orders, Cart and Profile navigation
    // will be connected with the existing
    // customer navigation flow.
  }

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
              child: _buildScrollableContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
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
              'Biscuits & Cookies',
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
  // SCROLLABLE CONTENT
  // ============================================================

  Widget _buildScrollableContent() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        _buildSearchBar(),
        _buildBrandFilters(),
        _buildProductList(),
      ],
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingMedium,
        AppSizes.paddingMedium,
        AppSizes.paddingMedium,
        AppSizes.paddingSmall,
      ),
      child: Container(
        height: AppSizes.inputHeight,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: TextField(
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.searchBiscuits,
            hintStyle: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.bodyText,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.secondaryTextColor,
              size: AppSizes.iconMedium,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSizes.paddingMedium,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BRAND FILTERS
  // ============================================================

  Widget _buildBrandFilters() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingSmall,
        ),
        itemCount: _brands.length,
        separatorBuilder: (_, _) {
          return const SizedBox(
            width: AppSizes.spacingSmall,
          );
        },
        itemBuilder: (context, index) {
          final bool isSelected =
              _selectedBrandIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedBrandIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              height: 36,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLarge,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : const Color(0xFFEAF0F6),
                borderRadius: BorderRadius.circular(
                  AppSizes.buttonRadius,
                ),
              ),
              child: Text(
                _brands[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.primaryTextColor,
                  fontSize: AppSizes.smallText,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // PRODUCT LIST
  // ============================================================

  Widget _buildProductList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingSmall,
        AppSizes.paddingSmall,
        AppSizes.paddingSmall,
        AppSizes.paddingExtraLarge,
      ),
      child: Column(
        children: [
          for (int index = 0;
              index < _products.length;
              index++) ...[
            _ProductCard(
              product: _products[index],
              onAdd: () {
                _showAddedMessage(
                  _products[index],
                );
              },
            ),
            if (index != _products.length - 1)
              const SizedBox(
                height: AppSizes.spacingSmall,
              ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // ADD TO CART FEEDBACK
  // ============================================================

  void _showAddedMessage(_Product product) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '${product.name} added to cart',
          ),
          duration: const Duration(
            milliseconds: 1200,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

// =================================================================
// PRODUCT CARD
// =================================================================

class _ProductCard extends StatelessWidget {
  final _Product product;
  final VoidCallback onAdd;

  const _ProductCard({
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardColor,
      elevation: AppSizes.cardElevation,
      shadowColor: Colors.black.withValues(
        alpha: 0.08,
      ),
      borderRadius: BorderRadius.circular(
        AppSizes.cardRadius,
      ),
      child: Container(
        height: 106,
        padding: const EdgeInsets.all(
          AppSizes.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(
            AppSizes.cardRadius,
          ),
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: Row(
          children: [
            _buildPlaceholderImage(),

            const SizedBox(
              width: AppSizes.spacingMedium,
            ),

            Expanded(
              child: _buildProductInformation(),
            ),

            const SizedBox(
              width: AppSizes.spacingSmall,
            ),

            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BLANK PRODUCT IMAGE PLACEHOLDER
  // ============================================================

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(
          AppSizes.radiusSmall,
        ),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
    );
  }

  // ============================================================
  // PRODUCT INFORMATION
  // ============================================================

  Widget _buildProductInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(
          height: 2,
        ),

        Text(
          product.brand,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.smallText,
          ),
        ),

        const SizedBox(
          height: AppSizes.spacingSmall,
        ),

        Row(
          children: [
            Text(
              product.price,
              style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              width: AppSizes.spacingSmall,
            ),

            Text(
              product.mrp,
              style: const TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: AppSizes.smallText,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // ADD BUTTON + QUANTITY
  // ============================================================

  Widget _buildAddButton() {
    return SizedBox(
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 68,
            height: 36,
            child: ElevatedButton(
              onPressed: onAdd,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.radiusSmall,
                  ),
                ),
              ),
              child: const Text(
                'ADD',
                style: TextStyle(
                  fontSize: AppSizes.smallText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          GestureDetector(
            onTap: () {
              // Variant selection will be added later.
            },
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    product.quantity,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: AppSizes.smallText,
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down,
                  size: AppSizes.iconSmall,
                  color: AppColors.primaryTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// PRODUCT MODEL
// =================================================================

class _Product {
  final String name;
  final String brand;
  final String price;
  final String mrp;
  final String quantity;

  const _Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.mrp,
    required this.quantity,
  });
}