import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  int _selectedVariantIndex = 0;

  final List<String> _variants = [
    '50g',
    '100g',
    '200g',
    '400g',
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
    // will be connected with the customer navigation flow.
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
              child: _buildContent(),
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
              AppStrings.productDetails,
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
  // MAIN CONTENT
  // ============================================================

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingSmall,
        AppSizes.paddingSmall,
        AppSizes.paddingSmall,
        AppSizes.paddingLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _buildProductInformation(),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _buildVariantSection(),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _buildPriceSection(),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _buildDescriptionSection(),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _buildAddToCartButton(),
        ],
      ),
    );
  }

  // ============================================================
  // PRODUCT IMAGE PLACEHOLDER
  // ============================================================

  Widget _buildProductImage() {
    return SizedBox(
      height: 145,
      width: double.infinity,
      child: Center(
        child: Container(
          width: 120,
          height: 135,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(
              AppSizes.radiusMedium,
            ),
            border: Border.all(
              color: AppColors.borderColor,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PRODUCT INFORMATION
  // ============================================================

  Widget _buildProductInformation() {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Biscuits & Cookies',
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          const Text(
            'Good Day Cashew',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.headingText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          const Text(
            'Britannia',
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VARIANT SECTION
  // ============================================================

  Widget _buildVariantSection() {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.selectVariant,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _variants.length,
              separatorBuilder: (_, _) {
                return const SizedBox(
                  width: AppSizes.spacingSmall,
                );
              },
              itemBuilder: (context, index) {
                final bool isSelected =
                    _selectedVariantIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedVariantIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 160,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMedium,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: Text(
                      _variants[index],
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.whiteColor
                            : AppColors.primaryColor,
                        fontSize: AppSizes.smallText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRICE SECTION
  // ============================================================

  Widget _buildPriceSection() {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.priceInformation,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          const Text(
            '₹45.00',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.headingText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 1,
          ),

          const Text(
            '₹50.00',
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildDescriptionSection() {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.productDescription,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.smallText,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: 'Key Ingredients: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text:
                      'Refined wheat flour (maida), sugar, palm oil, '
                      'cashew nuts (approx. 4.5%), milk solids, and butter.',
                ),
              ],
            ),
          ),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.smallText,
              ),
              children: [
                TextSpan(
                  text: 'Expiry Date: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: '02/2027.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ADD TO CART
  // ============================================================

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Good Day Cashew added to cart',
                ),
                duration: Duration(
                  milliseconds: 1200,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
          ),
        ),
        child: const Text(
          AppStrings.addToCart,
          style: TextStyle(
            fontSize: AppSizes.smallText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// =================================================================
// REUSABLE SECTION CARD
// =================================================================

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
              alpha: 0.04,
            ),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}