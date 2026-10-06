import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class AddVendorScreen extends StatefulWidget {
  const AddVendorScreen({super.key});

  @override
  State<AddVendorScreen> createState() => _AddVendorScreenState();
}

class _AddVendorScreenState extends State<AddVendorScreen> {
  int currentIndex = 0;

  final TextEditingController vendorNameController = TextEditingController();

  final TextEditingController contactPersonController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController gstController = TextEditingController();

  @override
  void dispose() {
    vendorNameController.dispose();
    contactPersonController.dispose();
    mobileController.dispose();
    emailController.dispose();
    gstController.dispose();
    super.dispose();
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
          'Add Vendor',
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
            _buildSectionTitle('Vendor Information'),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildTextField(
              controller: vendorNameController,
              label: 'Vendor Name',
              hintText: 'Enter vendor name',
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildTextField(
              controller: contactPersonController,
              label: 'Contact Person',
              hintText: 'Enter contact person name',
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildTextField(
              controller: mobileController,
              label: 'Mobile Number',
              hintText: 'Enter mobile number',
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildTextField(
              controller: emailController,
              label: 'Email',
              hintText: 'Enter email address',
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: AppSizes.spacingLarge),

            _buildTextField(
              controller: gstController,
              label: 'GST Number',
              hintText: 'Enter GST number',
              textCapitalization: TextCapitalization.characters,
            ),

            const SizedBox(height: AppSizes.spacingExtraLarge),

            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  ),
                ),
                child: const Text(
                  'Add Vendor',
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
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
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
    TextCapitalization textCapitalization = TextCapitalization.none,
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
          textCapitalization: textCapitalization,
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
}
