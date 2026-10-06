import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class OwnerOrderDetailsScreen extends StatefulWidget {
  const OwnerOrderDetailsScreen({super.key});

  @override
  State<OwnerOrderDetailsScreen> createState() =>
      _OwnerOrderDetailsScreenState();
}

class _OwnerOrderDetailsScreenState extends State<OwnerOrderDetailsScreen> {
  int currentIndex = 1;

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Coca-Cola 1 ltr.',
      'size': '1000ml',
      'quantity': 2,
      'price': 120.00,
    },
    {
      'name': 'Parle-G Gold Biscuit',
      'size': '1kg',
      'quantity': 1,
      'price': 249.00,
    },
    {
      'name': 'Chocolate Cokkies',
      'size': '500g',
      'quantity': 1,
      'price': 151.00,
    },
  ];

  void _cancelOrder() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order cancelled')));
  }

  void _completeOrder() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order marked as completed')));
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
          'Order Details',
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
            _buildCustomerCard(),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildOrderInformation(),

            const SizedBox(height: AppSizes.spacingExtraLarge),

            const Text(
              'Items',
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.headingText,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: AppSizes.spacingMedium),

            _buildProductList(),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildBillingSummary(),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildActionButtons(),

            const SizedBox(height: AppSizes.spacingMedium),
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

  Widget _buildCustomerCard() {
    return Container(
      width: double.infinity,
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
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                AppImages.placeholder,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person_outline,
                    color: AppColors.primaryColor,
                    size: AppSizes.iconLarge,
                  );
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
                  'Rakesh Sharma',
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '+91 99241 85476',
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
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

  Widget _buildOrderInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Column(
        children: [
          _buildInfoRow('Order ID', '#SM-114'),
          const SizedBox(height: AppSizes.spacingMedium),
          _buildInfoRow('Date', 'Jul 24, 2026 • 10:30 AM'),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status',
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: AppSizes.bodyText,
                ),
              ),
              _buildStatusBadge(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      ),
      child: const Text(
        'Pending',
        style: TextStyle(
          color: AppColors.warningColor,
          fontSize: AppSizes.smallText,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Column(
      children: products.map((product) {
        return _buildProductCard(product);
      }).toList(),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
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
                    size: AppSizes.iconLarge,
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
                  product['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingSmall),

                Text(
                  'Size: ${product['size']}',
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingSmall),

                Row(
                  children: [
                    Text(
                      'Qty: ${product['quantity']}',
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: AppSizes.smallText,
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacingLarge),
                    Text(
                      '₹${(product['price'] as double).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.priceColor,
                        fontSize: AppSizes.bodyText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          _buildBillingRow('Total Items', '4'),
          const SizedBox(height: AppSizes.spacingMedium),
          _buildBillingRow('Total Bill', '₹493.5', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildBillingRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isTotal
                ? AppColors.primaryTextColor
                : AppColors.secondaryTextColor,
            fontSize: isTotal ? AppSizes.mediumText : AppSizes.bodyText,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? AppColors.priceColor : AppColors.primaryTextColor,
            fontSize: isTotal ? AppSizes.mediumText : AppSizes.bodyText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _cancelOrder,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.errorColor,
              minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
              side: const BorderSide(color: AppColors.errorColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              ),
            ),
            child: const Text(
              'Cancel Order',
              style: TextStyle(
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(width: AppSizes.spacingMedium),

        Expanded(
          child: ElevatedButton(
            onPressed: _completeOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successColor,
              foregroundColor: AppColors.whiteColor,
              elevation: 0,
              minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              ),
            ),
            child: const Text(
              'Completed',
              style: TextStyle(
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
