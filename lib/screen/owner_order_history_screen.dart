import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class OwnerOrderHistoryScreen extends StatefulWidget {
  const OwnerOrderHistoryScreen({super.key});

  @override
  State<OwnerOrderHistoryScreen> createState() =>
      _OwnerOrderHistoryScreenState();
}

class _OwnerOrderHistoryScreenState extends State<OwnerOrderHistoryScreen> {
  int currentIndex = 1;
  int selectedTab = 0;

  final TextEditingController searchController = TextEditingController();

  final List<String> tabs = ['All', 'Pending', 'Received', 'Cancelled'];

  final List<Map<String, dynamic>> orders = [
    {
      'id': '#SM-049',
      'status': 'Received',
      'date': 'Oct 24, 2023 • 11:45 AM',
      'amount': '₹4,862.00',
      'vendor': 'Britannia',
      'items': '8 Items',
      'action': 'Reorder',
    },
    {
      'id': '#SM-047',
      'status': 'Pending',
      'date': 'Today • 02:30 PM',
      'amount': '₹6,410.50',
      'vendor': 'Amrut Sales',
      'items': '4 Items',
      'action': 'Edit Order',
    },
    {
      'id': '#SM-014',
      'status': 'Draft',
      'date': 'Oct 20, 2023 • 09:10 AM',
      'amount': '₹2,100.00',
      'vendor': 'Balaji Wafers',
      'items': '12 Items',
      'action': 'Generate Order',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredOrders {
    final query = searchController.text.toLowerCase();

    List<Map<String, dynamic>> result = orders;

    if (selectedTab != 0) {
      final selectedStatus = tabs[selectedTab];

      result = result.where((order) {
        if (selectedStatus == 'Cancelled') {
          return order['status'] == 'Cancelled';
        }

        return order['status'] == selectedStatus;
      }).toList();
    }

    if (query.isNotEmpty) {
      result = result.where((order) {
        return order['id'].toString().toLowerCase().contains(query) ||
            order['vendor'].toString().toLowerCase().contains(query);
      }).toList();
    }

    return result;
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
          'Order History',
          style: TextStyle(
            fontSize: AppSizes.headingText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchField(),
          _buildTabs(),
          Expanded(child: _buildOrderList()),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        isOwner: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
        AppSizes.paddingMedium,
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Search for orders',
          hintStyle: const TextStyle(
            color: AppColors.hintTextColor,
            fontSize: AppSizes.bodyText,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.secondaryTextColor,
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.secondaryTextColor,
                  ),
                )
              : null,
          filled: true,
          fillColor: AppColors.inputBackgroundColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingMedium,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.inputRadius),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.inputRadius),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.inputRadius),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final bool isSelected = selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: AppSizes.spacingSmall),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.inputBackgroundColor,
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.borderColor,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.secondaryTextColor,
                  fontSize: AppSizes.smallText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderList() {
    final currentOrders = filteredOrders;

    if (currentOrders.isEmpty) {
      return const Center(
        child: Text(
          'No orders found',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      itemCount: currentOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(currentOrders[index]);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order['id'],
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildStatusBadge(order['status']),
            ],
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          Text(
            order['date'],
            style: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: const Icon(
                  Icons.store_outlined,
                  color: AppColors.primaryColor,
                  size: AppSizes.iconMedium,
                ),
              ),

              const SizedBox(width: AppSizes.spacingMedium),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['vendor'],
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: AppSizes.bodyText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order['items'],
                      style: const TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: AppSizes.smallText,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                order['amount'],
                style: const TextStyle(
                  color: AppColors.priceColor,
                  fontSize: AppSizes.mediumText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    minimumSize: const Size(double.infinity, 40),
                    side: const BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                    ),
                  ),
                  child: Text(
                    order['action'],
                    style: const TextStyle(
                      fontSize: AppSizes.smallText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: AppSizes.spacingMedium),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                    ),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: AppSizes.smallText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Received':
        backgroundColor = AppColors.successColor.withValues(alpha: 0.12);
        textColor = AppColors.successColor;
        break;

      case 'Pending':
        backgroundColor = AppColors.warningColor.withValues(alpha: 0.14);
        textColor = AppColors.warningColor;
        break;

      case 'Cancelled':
        backgroundColor = AppColors.errorColor.withValues(alpha: 0.12);
        textColor = AppColors.errorColor;
        break;

      default:
        backgroundColor = AppColors.secondaryTextColor.withValues(alpha: 0.12);
        textColor = AppColors.secondaryTextColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: AppSizes.extraSmallText,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
