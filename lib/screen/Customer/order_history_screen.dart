import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() =>
      _OrderHistoryScreenState();
}

class _OrderHistoryScreenState
    extends State<OrderHistoryScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    'All',
    'Pending',
    'Completed',
    'Cancelled',
  ];

  final List<_Order> _orders = const [
    _Order(
      orderNumber: '#SM-049',
      status: 'Delivered',
      date: 'Oct 24, 2023 • 11:45 AM',
      total: '₹1,250.00',
      itemCount: '8 Items',
      address: 'Sector 15, Vashi, Navi Mumbai, 400703',
      action: 'Reorder',
    ),
    _Order(
      orderNumber: '#SM-047',
      status: 'Pending',
      date: 'Today • 02:30 PM',
      total: '₹840.50',
      itemCount: '4 Items',
      address: 'Lodha Supremus, Powai, Mumbai, 400076',
      action: 'Track Order',
    ),
    _Order(
      orderNumber: '#SM-014',
      status: 'Cancelled',
      date: 'Oct 20, 2023 • 09:10 AM',
      total: '₹2,100.00',
      itemCount: '12 Items',
      address:
          'Hiranandani Gardens, Powai, Mumbai, 400076',
      action: 'Help',
    ),
  ];

  void _onBottomNavTap(int index) {
    if (index == 1) {
      return;
    }

    // Other customer navigation screens
    // will be connected here.
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
        currentIndex: 1,
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
              AppStrings.orderHistory,
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
      padding: const EdgeInsets.only(
        bottom: AppSizes.paddingExtraLarge,
      ),
      children: [
        _buildSearchBar(),

        const SizedBox(
          height: AppSizes.spacingMedium,
        ),

        _buildFilters(),

        const SizedBox(
          height: AppSizes.spacingLarge,
        ),

        _buildOrderList(),
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
        AppSizes.paddingLarge,
        AppSizes.paddingMedium,
        0,
      ),
      child: Container(
        height: 44,
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
            fontSize: AppSizes.smallText,
          ),
          decoration: InputDecoration(
            hintText: 'Search for orders',
            hintStyle: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.extraSmallText,
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
  // FILTERS
  // ============================================================

  Widget _buildFilters() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
        ),
        itemCount: _filters.length,
        separatorBuilder: (_, _) {
          return const SizedBox(
            width: AppSizes.spacingSmall,
          );
        },
        itemBuilder: (context, index) {
          final bool isSelected =
              _selectedFilterIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              height: 34,
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
                _filters[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.primaryTextColor,
                  fontSize: AppSizes.extraSmallText,
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
  // ORDER LIST
  // ============================================================

  Widget _buildOrderList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
      ),
      child: Column(
        children: [
          for (int index = 0;
              index < _orders.length;
              index++) ...[
            _OrderCard(
              order: _orders[index],
              onPrimaryAction: () {
                _handlePrimaryAction(
                  _orders[index],
                );
              },
              onViewDetails: () {
                _viewOrderDetails(
                  _orders[index],
                );
              },
            ),

            if (index != _orders.length - 1)
              const SizedBox(
                height: AppSizes.spacingLarge,
              ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // ORDER ACTIONS
  // ============================================================

  void _handlePrimaryAction(_Order order) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '${order.action}: ${order.orderNumber}',
          ),
          duration: const Duration(
            milliseconds: 1200,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _viewOrderDetails(_Order order) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Opening ${order.orderNumber}',
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
// ORDER CARD
// =================================================================

class _OrderCard extends StatelessWidget {
  final _Order order;
  final VoidCallback onPrimaryAction;
  final VoidCallback onViewDetails;

  const _OrderCard({
    required this.order,
    required this.onPrimaryAction,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              alpha: 0.05,
            ),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderHeader(),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          _buildDivider(),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          _buildOrderItem(),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          _buildDivider(),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),

          _buildActions(),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER HEADER
  // ============================================================

  Widget _buildOrderHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    order.orderNumber,
                    style: const TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: AppSizes.bodyText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    width: AppSizes.spacingSmall,
                  ),

                  _StatusBadge(
                    status: order.status,
                  ),
                ],
              ),

              const SizedBox(
                height: AppSizes.spacingSmall,
              ),

              Text(
                order.date,
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
          order.total,
          style: TextStyle(
            color: order.status == 'Cancelled'
                ? AppColors.secondaryTextColor
                : AppColors.priceColor,
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ORDER ITEM
  // ============================================================

  Widget _buildOrderItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                order.itemCount,
                style: const TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: AppSizes.smallText,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: AppSizes.spacingSmall,
              ),

              Text(
                order.address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: AppSizes.extraSmallText,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
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

  // ============================================================
  // ACTIONS
  // ============================================================

  Widget _buildActions() {
    final bool isCancelled =
        order.status == 'Cancelled';

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 38,
            child: OutlinedButton(
              onPressed: onPrimaryAction,
              style: OutlinedButton.styleFrom(
                foregroundColor: isCancelled
                    ? AppColors.secondaryTextColor
                    : AppColors.primaryColor,
                side: BorderSide(
                  color: isCancelled
                      ? AppColors.secondaryTextColor
                      : AppColors.primaryColor,
                ),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.radiusSmall,
                  ),
                ),
              ),
              child: Text(
                order.action,
                style: const TextStyle(
                  fontSize: AppSizes.extraSmallText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(
          width: AppSizes.spacingMedium,
        ),

        Expanded(
          child: SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: isCancelled
                  ? null
                  : onViewDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primaryColor,
                disabledBackgroundColor:
                    const Color(0xFFEAF0F6),
                disabledForegroundColor:
                    AppColors.secondaryTextColor,
                foregroundColor:
                    AppColors.whiteColor,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.radiusSmall,
                  ),
                ),
              ),
              child: const Text(
                AppStrings.orderDetails,
                style: TextStyle(
                  fontSize: AppSizes.extraSmallText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color(0xFFF0F0F0),
    );
  }
}

// =================================================================
// STATUS BADGE
// =================================================================

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Delivered':
        backgroundColor = const Color(0xFFE7F5EB);
        textColor = AppColors.successColor;
        break;

      case 'Pending':
        backgroundColor = const Color(0xFFFFEFD9);
        textColor = AppColors.warningColor;
        break;

      case 'Cancelled':
        backgroundColor = const Color(0xFFFFE2E2);
        textColor = AppColors.errorColor;
        break;

      default:
        backgroundColor =
            AppColors.inputBackgroundColor;
        textColor =
            AppColors.secondaryTextColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AppSizes.buttonRadius,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =================================================================
// ORDER MODEL
// =================================================================

class _Order {
  final String orderNumber;
  final String status;
  final String date;
  final String total;
  final String itemCount;
  final String address;
  final String action;

  const _Order({
    required this.orderNumber,
    required this.status,
    required this.date,
    required this.total,
    required this.itemCount,
    required this.address,
    required this.action,
  });
}