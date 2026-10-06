import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class VendorOrderGenerationScreen extends StatefulWidget {
  const VendorOrderGenerationScreen({super.key});

  @override
  State<VendorOrderGenerationScreen> createState() =>
      _VendorOrderGenerationScreenState();
}

class _VendorOrderGenerationScreenState
    extends State<VendorOrderGenerationScreen> {
  int currentIndex = 2;

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> products = [
    {'name': 'Good Day Cashew', 'size': '200g', 'mrp': 50.0, 'quantity': 12},
    {'name': 'Marie Light', 'size': '200g', 'mrp': 50.0, 'quantity': 0},
    {'name': 'Tiger Krunch', 'size': '200g', 'mrp': 50.0, 'quantity': 6},
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _increaseQuantity(int index) {
    setState(() {
      products[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    if (products[index]['quantity'] > 0) {
      setState(() {
        products[index]['quantity']--;
      });
    }
  }

  void _removeProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  int get totalItems {
    return products.length;
  }

  int get totalQuantity {
    int total = 0;

    for (final product in products) {
      total += product['quantity'] as int;
    }

    return total;
  }

  double get totalBill {
    double total = 0;

    for (final product in products) {
      total += (product['mrp'] as double) * (product['quantity'] as int);
    }

    return total;
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
          'Britannia',
          style: TextStyle(
            fontSize: AppSizes.headingText,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVendorCard(),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildSearchField(),

            const SizedBox(height: AppSizes.spacingMedium),

            _buildAddProductButton(),

            const SizedBox(height: AppSizes.spacingLarge),

            const Text(
              'Products',
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.headingText,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: AppSizes.spacingMedium),

            _buildProductList(),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildOrderSummary(),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildActionButtons(),

            const SizedBox(height: AppSizes.spacingMedium),
          ],
        ),
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

  Widget _buildVendorCard() {
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
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              child: Image.network(
                AppImages.placeholder,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.store_outlined,
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
                  'United Sales Agency',
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Britannia Distributor',
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Sanjay Bhai',
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '+91 94576 22133',
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search Product',
        hintStyle: const TextStyle(
          color: AppColors.hintTextColor,
          fontSize: AppSizes.bodyText,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.secondaryTextColor,
        ),
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
    );
  }

  Widget _buildAddProductButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add, size: AppSizes.iconMedium),
        label: const Text(
          'Add Product',
          style: TextStyle(
            fontSize: AppSizes.bodyText,
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
    );
  }

  Widget _buildProductList() {
    return Column(
      children: products.asMap().entries.map((entry) {
        return _buildProductCard(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildProductCard(int index, Map<String, dynamic> product) {
    final int quantity = product['quantity'] as int;
    final double mrp = product['mrp'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
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
                  product['size'],
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingSmall),

                Text(
                  'MRP : ₹${mrp.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.smallText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSizes.spacingSmall),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  _removeProduct(index);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.secondaryTextColor,
                  size: AppSizes.iconMedium,
                ),
              ),

              const SizedBox(height: AppSizes.spacingSmall),

              _buildQuantityControl(index, quantity),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(int index, int quantity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildQuantityButton(
          icon: Icons.remove,
          onTap: () {
            _decreaseQuantity(index);
          },
        ),

        SizedBox(
          width: 34,
          child: Center(
            child: Text(
              '$quantity',
              style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        _buildQuantityButton(
          icon: Icons.add,
          onTap: () {
            _increaseQuantity(index);
          },
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.whiteColor, size: 14),
      ),
    );
  }

  Widget _buildOrderSummary() {
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
          _buildSummaryRow('Total Items', '$totalItems'),
          const SizedBox(height: AppSizes.spacingMedium),
          _buildSummaryRow('Total Qty', '$totalQuantity'),
          const SizedBox(height: AppSizes.spacingMedium),
          _buildSummaryRow(
            'Total Bill',
            '₹${totalBill.toStringAsFixed(1)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
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
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              ),
            ),
            child: const Text(
              'Save as Draft',
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              ),
            ),
            child: const Text(
              'Generate Order',
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
