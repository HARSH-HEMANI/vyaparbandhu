import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  int _defaultAddressIndex = 0;

  final List<_Address> _addresses = [
    _Address(
      title: 'Home',
      address: 'Flat 402, xyz Apartment, Bangalore, Karnataka - 560102',
      phone: '+91 98765 43210',
    ),
    _Address(
      title: 'Work',
      address: 'Flat 402, xyz Apartment, Bangalore, Karnataka - 560102',
      phone: '+91 98765 71111',
    ),
  ];

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _onBottomNavTap(int index) {
    if (index == 3) {
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
        Navigator.pushReplacementNamed(context, '/customer-orders');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/customer-cart');
        break;
      case 3:
        break;
    }
  }

  // ============================================================
  // SET DEFAULT ADDRESS
  // ============================================================

  void _setDefaultAddress(int index) {
    setState(() {
      _defaultAddressIndex = index;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${_addresses[index].title} set as default address'),
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // EDIT ADDRESS
  // ============================================================

  void _editAddress(int index) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Edit ${_addresses[index].title} address'),
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // DELETE ADDRESS
  // ============================================================

  void _deleteAddress(int index) {
    if (_addresses.length == 1) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('At least one address is required'),
            duration: Duration(milliseconds: 1200),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    final String deletedAddress = _addresses[index].title;

    setState(() {
      _addresses.removeAt(index);

      if (_defaultAddressIndex == index) {
        _defaultAddressIndex = 0;
      } else if (_defaultAddressIndex > index) {
        _defaultAddressIndex--;
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$deletedAddress address deleted'),
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // ADD NEW ADDRESS
  // ============================================================

  void _addNewAddress() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Add New Address screen will be connected next.'),
          duration: Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
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
              AppStrings.myAddress,
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

  Widget _buildContent() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingSmall,
        AppSizes.paddingLarge,
        AppSizes.paddingSmall,
        AppSizes.paddingExtraLarge,
      ),
      children: [
        const Text(
          AppStrings.savedAddresses,
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: AppSizes.spacingLarge),

        _buildAddressList(),

        const SizedBox(height: AppSizes.spacingLarge),

        _buildAddAddressButton(),
      ],
    );
  }

  // ============================================================
  // ADDRESS LIST
  // ============================================================

  Widget _buildAddressList() {
    return Column(
      children: [
        for (int index = 0; index < _addresses.length; index++) ...[
          _AddressCard(
            address: _addresses[index],
            isDefault: _defaultAddressIndex == index,
            onEdit: () {
              _editAddress(index);
            },
            onDelete: () {
              _deleteAddress(index);
            },
            onSetDefault: () {
              _setDefaultAddress(index);
            },
          ),

          if (index != _addresses.length - 1)
            const SizedBox(height: AppSizes.spacingLarge),
        ],
      ],
    );
  }

  // ============================================================
  // ADD ADDRESS BUTTON
  // ============================================================

  Widget _buildAddAddressButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 42,
        child: ElevatedButton.icon(
          onPressed: _addNewAddress,
          icon: const Icon(Icons.add, size: AppSizes.iconSmall),
          label: const Text(
            AppStrings.addNewAddress,
            style: TextStyle(
              fontSize: AppSizes.extraSmallText,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.whiteColor,
            elevation: 2,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            ),
          ),
        ),
      ),
    );
  }
}

// =================================================================
// ADDRESS CARD
// =================================================================

class _AddressCard extends StatelessWidget {
  final _Address address;
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const _AddressCard({
    required this.address,
    required this.isDefault,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: isDefault ? AppColors.primaryColor : AppColors.borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddressIcon(),

              const SizedBox(width: AppSizes.spacingMedium),

              Expanded(child: _buildAddressInformation()),

              const SizedBox(width: AppSizes.spacingSmall),

              _buildActions(),
            ],
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          Container(height: 1, color: const Color(0xFFEAEAEA)),

          const SizedBox(height: AppSizes.spacingMedium),

          _buildDefaultSelector(),
        ],
      ),
    );
  }

  // ============================================================
  // ADDRESS ICON
  // ============================================================

  Widget _buildAddressIcon() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: isDefault ? const Color(0xFFE6F3F9) : const Color(0xFFF1F1F1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        address.title == 'Home' ? Icons.home_outlined : Icons.work_outline,
        color: AppColors.secondaryTextColor,
        size: AppSizes.iconSmall,
      ),
    );
  }

  // ============================================================
  // ADDRESS INFORMATION
  // ============================================================

  Widget _buildAddressInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                address.title,
                style: const TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: AppSizes.bodyText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (isDefault) ...[
              const SizedBox(width: AppSizes.spacingSmall),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F5EB),
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                ),
                child: const Text(
                  AppStrings.defaultAddress,
                  style: TextStyle(
                    color: AppColors.successColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: AppSizes.spacingSmall),

        Text(
          address.address,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.smallText,
            height: 1.35,
          ),
        ),

        const SizedBox(height: AppSizes.spacingSmall),

        Row(
          children: [
            const Icon(
              Icons.phone_outlined,
              size: 12,
              color: AppColors.secondaryTextColor,
            ),

            const SizedBox(width: 4),

            Text(
              address.phone,
              style: const TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: AppSizes.extraSmallText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // EDIT / DELETE ACTIONS
  // ============================================================

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onEdit,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          icon: const Icon(
            Icons.edit_outlined,
            color: AppColors.primaryTextColor,
            size: AppSizes.iconSmall,
          ),
        ),

        IconButton(
          onPressed: onDelete,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          icon: const Icon(
            Icons.delete_outline,
            color: AppColors.errorColor,
            size: AppSizes.iconSmall,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DEFAULT ADDRESS SELECTOR
  // ============================================================

  Widget _buildDefaultSelector() {
    return GestureDetector(
      onTap: isDefault ? null : onSetDefault,
      child: Row(
        children: [
          Icon(
            isDefault
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: isDefault
                ? AppColors.primaryColor
                : AppColors.secondaryTextColor,
            size: AppSizes.iconSmall,
          ),

          const SizedBox(width: AppSizes.spacingSmall),

          Text(
            AppStrings.setAsDefaultAddress,
            style: TextStyle(
              color: isDefault
                  ? AppColors.primaryTextColor
                  : AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
              fontWeight: isDefault ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// ADDRESS MODEL
// =================================================================

class _Address {
  final String title;
  final String address;
  final String phone;

  const _Address({
    required this.title,
    required this.address,
    required this.phone,
  });
}
