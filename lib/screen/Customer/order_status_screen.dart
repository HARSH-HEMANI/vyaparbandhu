import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar(BuildContext context) {
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
              'Order Status',
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
  // CONTENT
  // ============================================================

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingMedium,
        AppSizes.paddingExtraLarge,
        AppSizes.paddingMedium,
        AppSizes.paddingExtraLarge,
      ),
      child: Column(
        children: [
          _buildSuccessIcon(),

          const SizedBox(height: AppSizes.spacingLarge),

          _buildSuccessMessage(),

          const SizedBox(height: AppSizes.spacingExtraLarge),

          _buildOrderSummary(),

          const SizedBox(height: AppSizes.spacingExtraLarge),

          _buildContinueShoppingButton(context),

          const SizedBox(height: AppSizes.spacingExtraLarge),

          _buildFooterMessage(),
        ],
      ),
    );
  }

  // ============================================================
  // SUCCESS ICON
  // ============================================================

  Widget _buildSuccessIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: AppColors.successColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        color: AppColors.whiteColor,
        size: AppSizes.iconMedium,
      ),
    );
  }

  // ============================================================
  // SUCCESS MESSAGE
  // ============================================================

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        const Text(
          AppStrings.orderPlacedSuccessfully,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.titleText,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),

        const SizedBox(height: AppSizes.spacingMedium),

        const Text(
          'Thank you for shopping with VyaparBandhu.\n'
          'Your order has been received and will be\n'
          'processed shortly.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.extraSmallText,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ORDER SUMMARY
  // ============================================================

  Widget _buildOrderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _SummaryRow(label: '${AppStrings.totalItems} (3)', value: '3 Items'),

          const SizedBox(height: AppSizes.spacingMedium),

          _SummaryRow(
            label: 'Payment Status',
            value: 'Paid',
            valueColor: AppColors.successColor,
            isPaid: true,
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          Container(height: 1, color: const Color(0xFFF0F0F0)),

          const SizedBox(height: AppSizes.spacingMedium),

          _SummaryRow(
            label: AppStrings.grandTotal,
            value: '₹340.00',
            isGrandTotal: true,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONTINUE SHOPPING
  // ============================================================

  Widget _buildContinueShoppingButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/customer-home',
            (route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
        child: const Text(
          AppStrings.continueShopping,
          style: TextStyle(
            fontSize: AppSizes.smallText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FOOTER MESSAGE
  // ============================================================

  Widget _buildFooterMessage() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          color: AppColors.secondaryTextColor,
          fontSize: AppSizes.extraSmallText,
        ),
        children: [
          TextSpan(text: 'Thank you for choosing '),
          TextSpan(
            text: AppStrings.appName,
            style: TextStyle(color: AppColors.primaryColor),
          ),
          TextSpan(text: '.'),
        ],
      ),
    );
  }
}

// =================================================================
// SUMMARY ROW
// =================================================================

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isGrandTotal;
  final bool isPaid;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isGrandTotal = false,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: isGrandTotal
                  ? AppColors.primaryTextColor
                  : AppColors.secondaryTextColor,
              fontSize: isGrandTotal
                  ? AppSizes.bodyText
                  : AppSizes.extraSmallText,
              fontWeight: isGrandTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),

        if (isPaid)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.successColor,
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Text(
            value,
            style: TextStyle(
              color:
                  valueColor ??
                  (isGrandTotal
                      ? AppColors.priceColor
                      : AppColors.primaryTextColor),
              fontSize: isGrandTotal
                  ? AppSizes.headingText
                  : AppSizes.extraSmallText,
              fontWeight: isGrandTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
      ],
    );
  }
}
