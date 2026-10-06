import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class VendorDetailsScreen extends StatefulWidget {
  const VendorDetailsScreen({super.key, this.vendorName = 'Britannia'});

  final String vendorName;

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  int currentIndex = 2;

  final List<Map<String, String>> products = [
    {
      'name': 'Good Day Cashew',
      'price': '₹41',
      'category': 'Biscuits & Cookies',
    },
    {
      'name': 'Good Day Butter',
      'price': '₹35',
      'category': 'Biscuits & Cookies',
    },
    {'name': 'Marie Gold', 'price': '₹30', 'category': 'Biscuits & Cookies'},
    {'name': 'Tiger Glucose', 'price': '₹20', 'category': 'Biscuits & Cookies'},
  ];

  void _openProductDetails(Map<String, String> product) {
    Navigator.pushNamed(context, '/product-details', arguments: product);
  }

  void _onBottomNavTap(int index) {
    if (index == currentIndex) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        title: const Text(
          'Vendor Details',
          style: TextStyle(
            fontSize: AppSizes.headingText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVendorHeader(),
            const SizedBox(height: AppSizes.spacingLarge),
            _buildVendorInformation(),
            const SizedBox(height: AppSizes.spacingExtraLarge),
            _buildProductsSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        isOwner: true,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _buildVendorHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
            ),
            child: ClipOval(
              child: Image.network(
                AppImages.placeholder,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.store,
                    color: AppColors.primaryColor,
                    size: AppSizes.iconLarge,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingLarge),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vendorName,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppSizes.titleText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingSmall),
                const Text(
                  'Vendor / Brand',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppSizes.bodyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vendor Information',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.headingText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLarge),
          _buildInformationRow(
            Icons.person_outline,
            'Contact Person',
            'Rajesh Patel',
          ),
          _buildInformationRow(
            Icons.phone_outlined,
            'Mobile Number',
            '+91 98765 43210',
          ),
          _buildInformationRow(
            Icons.email_outlined,
            'Email',
            'vendor@example.com',
          ),
          _buildInformationRow(
            Icons.receipt_long_outlined,
            'GST Number',
            '24ABCDE1234F1Z5',
          ),
        ],
      ),
    );
  }

  Widget _buildInformationRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: AppSizes.iconMedium),
          const SizedBox(width: AppSizes.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.bodyText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Products',
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.headingText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        const Text(
          'Products available from this vendor',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
        const SizedBox(height: AppSizes.spacingLarge),
        ...products.map((product) => _buildProductCard(product)),
      ],
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        onTap: () {
          _openProductDetails(product);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              child: Image.network(
                AppImages.placeholder,
                width: AppSizes.productImageSize,
                height: AppSizes.productImageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: AppSizes.productImageSize,
                    height: AppSizes.productImageSize,
                    color: AppColors.inputBackgroundColor,
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.secondaryTextColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: AppSizes.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: const TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: AppSizes.mediumText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingSmall),
                  Text(
                    product['category']!,
                    style: const TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: AppSizes.smallText,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingSmall),
                  Text(
                    product['price']!,
                    style: const TextStyle(
                      color: AppColors.priceColor,
                      fontSize: AppSizes.mediumText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.secondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
