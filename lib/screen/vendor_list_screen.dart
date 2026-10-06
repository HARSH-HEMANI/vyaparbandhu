import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class VendorListScreen extends StatefulWidget {
  const VendorListScreen({super.key});

  @override
  State<VendorListScreen> createState() => _VendorListScreenState();
}

class _VendorListScreenState extends State<VendorListScreen> {
  int currentIndex = 2;

  final TextEditingController searchController = TextEditingController();

  final List<String> vendors = [
    'Britannia',
    'Sunfeast',
    'Balaji Wafers',
    'Amrut Sales',
    'Coca-Cola',
    'Cadbury',
    'Shan Marketing',
    'Nestle',
    'Kissan',
    'Unilever',
    'Nilon’s',
  ];

  List<String> filteredVendors = [];

  @override
  void initState() {
    super.initState();

    filteredVendors = vendors;

    searchController.addListener(_searchVendors);
  }

  @override
  void dispose() {
    searchController.removeListener(_searchVendors);
    searchController.dispose();
    super.dispose();
  }

  void _searchVendors() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredVendors = vendors.where((vendor) {
        return vendor.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _openAddVendor() {
    Navigator.pushNamed(context, '/add-vendor');
  }

  void _openVendorDetails(String vendor) {
    Navigator.pushNamed(context, '/vendor-details', arguments: vendor);
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
        setState(() {
          currentIndex = 2;
        });
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
          'Vendors',
          style: TextStyle(
            fontSize: AppSizes.headingText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          Expanded(child: _buildVendorList()),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        isOwner: true,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search by Vendor/Brand Name',
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
          const SizedBox(height: AppSizes.spacingMedium),
          SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: _openAddVendor,
              icon: const Icon(Icons.add, size: AppSizes.iconMedium),
              label: const Text(
                'Add Vendor/Brand',
                style: TextStyle(
                  fontSize: AppSizes.bodyText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: const BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorList() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingLarge,
        0,
        AppSizes.paddingLarge,
        AppSizes.paddingLarge,
      ),
      children: [
        const Text(
          'Vendors / Brands',
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.headingText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        const Text(
          'Explore various Distributors and Brands',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
        const SizedBox(height: AppSizes.spacingLarge),
        if (filteredVendors.isEmpty)
          _buildEmptyState()
        else
          ...filteredVendors.map((vendor) => _buildVendorCard(vendor)),
      ],
    );
  }

  Widget _buildVendorCard(String vendor) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
          child: const Icon(
            Icons.store_outlined,
            color: AppColors.primaryColor,
            size: AppSizes.iconMedium,
          ),
        ),
        title: Text(
          vendor,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text(
          'View vendor details',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.smallText,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.secondaryTextColor,
        ),
        onTap: () {
          _openVendorDetails(vendor);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.only(top: AppSizes.paddingExtraLarge),
      child: Center(
        child: Text(
          'No vendors found',
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
        ),
      ),
    );
  }
}
