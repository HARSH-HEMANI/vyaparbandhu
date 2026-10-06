import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class OwnerOrderSuccessScreen extends StatefulWidget {
  const OwnerOrderSuccessScreen({super.key});

  @override
  State<OwnerOrderSuccessScreen> createState() =>
      _OwnerOrderSuccessScreenState();
}

class _OwnerOrderSuccessScreenState extends State<OwnerOrderSuccessScreen> {
  int _currentIndex = 1;

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Status',
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
            _buildSuccessIcon(),
            const SizedBox(height: AppSizes.spacingLarge),
            const Text(
              'Order Generated Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.titleText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSmall),
            const Text(
              'Your order has been generated successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: AppSizes.bodyText,
              ),
            ),
            const SizedBox(height: AppSizes.spacingExtraLarge),
            _buildOrderCard(),
            const SizedBox(height: AppSizes.spacingExtraLarge),
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.download_outlined,
                  size: AppSizes.iconMedium,
                ),
                label: const Text(
                  'Download Order',
                  style: TextStyle(
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spacingMedium),
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  ),
                ),
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spacingLarge),
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

  Widget _buildSuccessIcon() {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.successColor.withValues(alpha: 0.1),
      ),
      child: const Icon(
        Icons.check_circle_outline,
        color: AppColors.successColor,
        size: 56,
      ),
    );
  }

  Widget _buildOrderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          _buildOrderRow('Order ID', '#SM-114'),
          const Divider(
            height: AppSizes.spacingExtraLarge,
            color: AppColors.borderColor,
          ),
          _buildOrderRow('Vendor', 'Britannia'),
          const Divider(
            height: AppSizes.spacingExtraLarge,
            color: AppColors.borderColor,
          ),
          _buildOrderRow('Total Items', '4'),
          const Divider(
            height: AppSizes.spacingExtraLarge,
            color: AppColors.borderColor,
          ),
          _buildOrderRow('Total Bill', '₹493.50'),
        ],
      ),
    );
  }

  Widget _buildOrderRow(String title, String value) {
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
