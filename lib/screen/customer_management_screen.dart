import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({super.key});

  @override
  State<CustomerManagementScreen> createState() =>
      _CustomerManagementScreenState();
}

class _CustomerManagementScreenState extends State<CustomerManagementScreen> {
  int currentIndex = 0;
  int selectedTab = 0;

  final List<String> tabs = ['Pending', 'Confirmed', 'Canceled'];

  final List<Map<String, dynamic>> customers = [
    {
      'name': 'Rakesh Sharma',
      'mobile': '+91 99241 85476',
      'orders': '3 Orders',
      'amount': '₹4,862.00',
      'status': 'Pending',
    },
    {
      'name': 'Jay Patel',
      'mobile': '+91 98765 43210',
      'orders': '5 Orders',
      'amount': '₹8,420.50',
      'status': 'Pending',
    },
    {
      'name': 'Amit Shah',
      'mobile': '+91 98254 12345',
      'orders': '2 Orders',
      'amount': '₹2,150.00',
      'status': 'Confirmed',
    },
    {
      'name': 'Neha Mehta',
      'mobile': '+91 99090 45678',
      'orders': '4 Orders',
      'amount': '₹6,740.00',
      'status': 'Canceled',
    },
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    final selectedStatus = tabs[selectedTab];

    return customers.where((customer) {
      return customer['status'] == selectedStatus;
    }).toList();
  }

  void _viewCustomerDetails(Map<String, dynamic> customer) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing details for ${customer['name']}')),
    );
  }

  void _updateCustomerStatus(Map<String, dynamic> customer) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Update status for ${customer['name']}')),
    );
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
          'View Customer',
          style: TextStyle(
            fontSize: AppSizes.headingText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(child: _buildCustomerList()),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        isOwner: true,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
        AppSizes.paddingMedium,
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = selectedTab == index;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index == tabs.length - 1 ? 0 : AppSizes.spacingSmall,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: Container(
                  height: 40,
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
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCustomerList() {
    final currentCustomers = filteredCustomers;

    if (currentCustomers.isEmpty) {
      return const Center(
        child: Text(
          'No customers found',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingLarge,
        AppSizes.paddingSmall,
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
      ),
      itemCount: currentCustomers.length,
      itemBuilder: (context, index) {
        return _buildCustomerCard(currentCustomers[index]);
      },
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline,
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
                      customer['name'],
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: AppSizes.mediumText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      customer['mobile'],
                      style: const TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: AppSizes.smallText,
                      ),
                    ),
                  ],
                ),
              ),

              _buildStatusBadge(customer['status']),
            ],
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          Row(
            children: [
              Expanded(
                child: _buildCustomerStat(
                  icon: Icons.receipt_long_outlined,
                  title: 'Orders',
                  value: customer['orders'],
                ),
              ),
              Container(width: 1, height: 38, color: AppColors.borderColor),
              Expanded(
                child: _buildCustomerStat(
                  icon: Icons.currency_rupee,
                  title: 'Total Amount',
                  value: customer['amount'],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _viewCustomerDetails(customer);
                  },
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
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: AppSizes.smallText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: AppSizes.spacingMedium),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _updateCustomerStatus(customer);
                  },
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
                    'Update Status',
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

  Widget _buildCustomerStat({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: AppSizes.iconMedium),
          const SizedBox(width: AppSizes.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.extraSmallText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.smallText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Confirmed':
        backgroundColor = AppColors.successColor.withValues(alpha: 0.12);
        textColor = AppColors.successColor;
        break;

      case 'Canceled':
        backgroundColor = AppColors.errorColor.withValues(alpha: 0.12);
        textColor = AppColors.errorColor;
        break;

      default:
        backgroundColor = AppColors.warningColor.withValues(alpha: 0.14);
        textColor = AppColors.warningColor;
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
