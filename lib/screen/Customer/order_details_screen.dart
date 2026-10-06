import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  static const List<_OrderItem> _items = [
    _OrderItem(
      name: 'Coca-Cola 1 ltr.',
      size: '1000ml',
      quantity: '2',
      price: '₹120.00',
    ),
    _OrderItem(
      name: 'Parle-G Gold Biscuit',
      size: '1kg',
      quantity: '1',
      price: '₹249.00',
    ),
    _OrderItem(
      name: 'Chocolate Cookies',
      size: '500g',
      quantity: '1',
      price: '₹151.00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          _onBottomNavTap(context, index);
        },
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
              AppStrings.orderDetails,
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
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingSmall,
        AppSizes.paddingMedium,
        AppSizes.paddingSmall,
        AppSizes.paddingExtraLarge,
      ),
      children: [
        _buildOrderSummary(),

        const SizedBox(
          height: AppSizes.spacingLarge,
        ),

        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingSmall,
          ),
          child: Text(
            'Items in your order',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.bodyText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(
          height: AppSizes.spacingMedium,
        ),

        _buildOrderItems(),

        const SizedBox(
          height: AppSizes.spacingLarge,
        ),

        _buildBillingDetails(),

        const SizedBox(
          height: AppSizes.spacingLarge,
        ),

        _buildDownloadInvoiceButton(),
      ],
    );
  }

  // ============================================================
  // ORDER SUMMARY
  // ============================================================

  Widget _buildOrderSummary() {
    return _SectionCard(
      padding: const EdgeInsets.all(
        AppSizes.paddingMedium,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoColumn(
                  label: 'Order ID',
                  value: '#SM-115',
                  valueColor: AppColors.primaryColor,
                ),
              ),
              _buildInfoColumn(
                label: 'Date',
                value: 'Jul 24, 2026 • 10:30 AM',
                alignEnd: true,
              ),
            ],
          ),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          Row(
            children: [
              _StatusBadge(
                icon: Icons.circle,
                text: 'Delivered',
                backgroundColor: const Color(0xFFE7F5EB),
                textColor: AppColors.successColor,
              ),

              const SizedBox(
                width: AppSizes.spacingSmall,
              ),

              _StatusBadge(
                icon: Icons.lock,
                text: 'Paid',
                backgroundColor: AppColors.successColor,
                textColor: AppColors.whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn({
    required String label,
    required String value,
    Color? valueColor,
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.extraSmallText,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          value,
          textAlign:
              alignEnd ? TextAlign.end : TextAlign.start,
          style: TextStyle(
            color:
                valueColor ?? AppColors.primaryTextColor,
            fontSize: AppSizes.smallText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ORDER ITEMS
  // ============================================================

  Widget _buildOrderItems() {
    return Column(
      children: [
        for (int index = 0;
            index < _items.length;
            index++) ...[
          _OrderItemCard(
            item: _items[index],
          ),
          if (index != _items.length - 1)
            const SizedBox(
              height: AppSizes.spacingMedium,
            ),
        ],
      ],
    );
  }

  // ============================================================
  // BILLING DETAILS
  // ============================================================

  Widget _buildBillingDetails() {
    return _SectionCard(
      padding: const EdgeInsets.all(
        AppSizes.paddingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Billing Details',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.bodyText,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          _buildBillingDivider(),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _BillingRow(
            label: 'Subtotal',
            value: '₹520.00',
          ),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _BillingRow(
            label: 'Discount',
            value: '-₹50.00',
            valueColor: AppColors.successColor,
          ),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _BillingRow(
            label: 'Delivery Fee',
            value: 'FREE',
            valueColor: AppColors.successColor,
          ),

          const SizedBox(
            height: AppSizes.spacingSmall,
          ),

          _BillingRow(
            label: 'Tax (GST)',
            value: '₹23.50',
          ),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          _buildBillingDivider(),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          _BillingRow(
            label: 'Grand Total',
            value: '₹493.50',
            isGrandTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBillingDivider() {
    return Container(
      height: 1,
      color: const Color(0xFFF0F0F0),
    );
  }

  // ============================================================
  // DOWNLOAD INVOICE
  // ============================================================

  Widget _buildDownloadInvoiceButton() {
    return SizedBox(
      height: AppSizes.buttonHeight,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          // Invoice download functionality
          // will be connected later.
        },
        icon: const Icon(
          Icons.download_outlined,
          size: AppSizes.iconSmall,
        ),
        label: const Text(
          AppStrings.downloadInvoice,
          style: TextStyle(
            fontSize: AppSizes.smallText,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(
            color: AppColors.primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.radiusSmall,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  void _onBottomNavTap(
    BuildContext context,
    int index,
  ) {
    if (index == 1) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/customer-home',
          (route) => false,
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/customer-cart');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/customer-profile');
        break;
    }
  }
}

// =================================================================
// ORDER ITEM CARD
// =================================================================

class _OrderItemCard extends StatelessWidget {
  final _OrderItem item;

  const _OrderItemCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      padding: const EdgeInsets.all(
        AppSizes.paddingSmall,
      ),
      child: Row(
        children: [
          _buildImagePlaceholder(),

          const SizedBox(
            width: AppSizes.spacingMedium,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.bodyText,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  'Size: ${item.size}',
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.extraSmallText,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  'Qty: ${item.quantity}',
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.extraSmallText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSizes.spacingSmall,
          ),

          Text(
            item.price,
            style: const TextStyle(
              color: AppColors.priceColor,
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 52,
      height: 52,
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
}

// =================================================================
// SECTION CARD
// =================================================================

class _SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const _SectionCard({
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ??
          const EdgeInsets.all(
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
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

// =================================================================
// STATUS BADGE
// =================================================================

class _StatusBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _StatusBadge({
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AppSizes.buttonRadius,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 7,
            color: textColor,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// BILLING ROW
// =================================================================

class _BillingRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isGrandTotal;

  const _BillingRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isGrandTotal = false,
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
              fontWeight: isGrandTotal
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ??
                (isGrandTotal
                    ? AppColors.priceColor
                    : AppColors.primaryTextColor),
            fontSize: isGrandTotal
                ? AppSizes.headingText
                : AppSizes.extraSmallText,
            fontWeight: isGrandTotal
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// =================================================================
// ORDER ITEM MODEL
// =================================================================

class _OrderItem {
  final String name;
  final String size;
  final String quantity;
  final String price;

  const _OrderItem({
    required this.name,
    required this.size,
    required this.quantity,
    required this.price,
  });
}