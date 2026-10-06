import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final int _currentIndex = 0;
  int _selectedVariant = 0;

  final List<String> _variants = ['100 g', '200 g', '500 g'];

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) {
      return;
    }

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

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductHeader(),
                  const SizedBox(height: AppSizes.spacingLarge),
                  _buildVariantSection(),
                  const SizedBox(height: AppSizes.spacingLarge),
                  _buildPriceSection(),
                  const SizedBox(height: AppSizes.spacingLarge),
                  _buildInformationSection(),
                  const SizedBox(height: AppSizes.spacingExtraLarge),
                  _buildActionButtons(),
                  const SizedBox(height: AppSizes.spacingLarge),
                ],
              ),
            ),
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

  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: 250,
      color: AppColors.inputBackgroundColor,
      padding: const EdgeInsets.all(AppSizes.paddingExtraLarge),
      child: Image.network(
        AppImages.placeholder,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_outlined,
            size: 80,
            color: AppColors.secondaryTextColor,
          );
        },
      ),
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good Day Cashew',
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.titleText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        const Text(
          'Britannia',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.successColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
          child: const Text(
            'In Stock',
            style: TextStyle(
              color: AppColors.successColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVariantSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Variant',
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        Wrap(
          spacing: AppSizes.spacingSmall,
          children: List.generate(_variants.length, (index) {
            final bool isSelected = _selectedVariant == index;

            return ChoiceChip(
              label: Text(_variants[index]),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedVariant = index;
                  });
                }
              },
              selectedColor: AppColors.primaryColor,
              backgroundColor: AppColors.inputBackgroundColor,
              labelStyle: TextStyle(
                color: isSelected
                    ? AppColors.whiteColor
                    : AppColors.primaryTextColor,
                fontSize: AppSizes.bodyText,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),
                SizedBox(height: AppSizes.spacingSmall),
                Text(
                  '₹120.00',
                  style: TextStyle(
                    color: AppColors.priceColor,
                    fontSize: AppSizes.titleText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'MRP',
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: AppSizes.smallText,
                ),
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              Text(
                '₹130.00',
                style: const TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: AppSizes.bodyText,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Information',
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        _buildInfoRow(
          'Description',
          'Delicious cashew cookies from Britannia.',
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        _buildInfoRow('Expiry', '6 Months'),
        const SizedBox(height: AppSizes.spacingMedium),
        _buildInfoRow('Vendor', 'United Sales Agency'),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.smallText,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          _showMessage('Product added to order');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
        ),
        child: const Text(
          'Add to Order',
          style: TextStyle(
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
