import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int currentIndex = 0;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();

  String? selectedBrand;
  String? selectedCategory;
  String? selectedSubCategory;

  final List<String> brands = [
    'Britannia',
    'Sunfeast',
    'Balaji Wafers',
    'Coca-Cola',
    'Cadbury',
    'Nestle',
  ];

  final List<String> categories = [
    'Biscuits & Cookies',
    'Chips & Namkeen',
    'Beverages & Juices',
    'Chocolates & Candies',
    'Noodles & Pasta',
  ];

  final List<String> subCategories = [
    'Biscuits',
    'Cookies',
    'Cream Biscuits',
    'Salted Biscuits',
  ];

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    mrpController.dispose();
    super.dispose();
  }

  void _addProduct() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Product added successfully')));

    Navigator.pushReplacementNamed(context, '/product-listing');
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
          'Add Product',
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
            _buildSectionTitle('Product Information'),
            const SizedBox(height: AppSizes.spacingLarge),

            _buildTextField(
              controller: productNameController,
              label: 'Product Name',
              hintText: 'e.g. Good Day',
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildDropdown(
              label: 'Brand',
              hintText: 'Select Brand',
              value: selectedBrand,
              items: brands,
              onChanged: (value) {
                setState(() {
                  selectedBrand = value;
                });
              },
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildDropdown(
              label: 'Category',
              hintText: 'e.g. Biscuits & Cookies',
              value: selectedCategory,
              items: categories,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  selectedSubCategory = null;
                });
              },
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildDropdown(
              label: 'SubCategory',
              hintText: 'e.g. Biscuits',
              value: selectedSubCategory,
              items: subCategories,
              onChanged: (value) {
                setState(() {
                  selectedSubCategory = value;
                });
              },
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildSectionTitle('Price Information'),
            const SizedBox(height: AppSizes.spacingLarge),

            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: priceController,
                    label: 'Price',
                    hintText: 'e.g. 41',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: AppSizes.spacingMedium),
                Expanded(
                  child: _buildTextField(
                    controller: mrpController,
                    label: 'MRP',
                    hintText: 'e.g. 45',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spacingExtraLarge),

            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: _addProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  ),
                ),
                child: const Text(
                  'Add Product',
                  style: TextStyle(
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spacingExtraLarge),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: AppSizes.headingText,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.hintTextColor,
              fontSize: AppSizes.bodyText,
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
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.hintTextColor,
              fontSize: AppSizes.bodyText,
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
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: AppSizes.bodyText,
                  color: AppColors.primaryTextColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
