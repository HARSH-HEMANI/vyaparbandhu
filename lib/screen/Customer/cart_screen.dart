import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_text_size.dart';
import '../../widgets/bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    AppStrings.all,
    AppStrings.popular,
    'Britannia',
    'Parle',
  ];

  final List<_CartItem> _cartItems = [
    _CartItem(
      name: 'Parle-G Gold',
      brand: 'Parle',
      size: '200g',
      price: 45.0,
      quantity: 1,
    ),
    _CartItem(
      name: 'Good Day',
      brand: 'Britannia',
      size: '420g',
      price: 80.0,
      quantity: 2,
    ),
    _CartItem(
      name: 'Dark Fantasy',
      brand: 'Sunfeast',
      size: '150g',
      price: 45.0,
      quantity: 3,
    ),
  ];

  // ============================================================
  // CART CALCULATIONS
  // ============================================================

  double get _subtotal {
    double total = 0;

    for (final item in _cartItems) {
      total += item.price * item.quantity;
    }

    return total;
  }

  double get _discount {
    return 40.0;
  }

  double get _grandTotal {
    return _subtotal - _discount;
  }

  int get _totalItems {
    int total = 0;

    for (final item in _cartItems) {
      total += item.quantity;
    }

    return total;
  }

  // ============================================================
  // CUSTOMER BOTTOM NAVIGATION
  // ============================================================

  void _onBottomNavTap(int index) {
    if (index == 2) {
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
        break;

      case 3:
        Navigator.pushReplacementNamed(context, '/customer-profile');
        break;
    }
  }

  // ============================================================
  // QUANTITY
  // ============================================================

  void _increaseQuantity(int index) {
    setState(() {
      _cartItems[index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      }
    });
  }

  // ============================================================
  // REMOVE ITEM
  // ============================================================

  void _removeItem(int index) {
    final removedItem = _cartItems[index];

    setState(() {
      _cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${removedItem.name} removed from cart'),
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,

        body: Column(
          children: [
            // ==================================================
            // BLUE STATUS BAR + APP BAR
            // ==================================================
            Container(
              width: double.infinity,
              color: AppColors.primaryColor,
              child: SafeArea(bottom: false, child: _buildAppBar()),
            ),

            // ==================================================
            // CART CONTENT
            // ==================================================
            Expanded(child: _buildScrollableContent()),
          ],
        ),

        // ======================================================
        // BOTTOM NAVIGATION
        // ======================================================
        bottomNavigationBar: BottomNavBar(
          currentIndex: 2,
          onTap: _onBottomNavTap,
        ),
      ),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar() {
    return SizedBox(
      height: AppSizes.appBarHeight,
      width: double.infinity,
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
              AppStrings.cart,
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
      padding: const EdgeInsets.only(bottom: AppSizes.paddingExtraLarge),
      children: [
        _buildSearchBar(),

        const SizedBox(height: AppSizes.spacingMedium),

        _buildFilters(),

        const SizedBox(height: AppSizes.spacingLarge),

        _buildCartItems(),

        const SizedBox(height: AppSizes.spacingLarge),

        _buildOrderSummary(),

        const SizedBox(height: AppSizes.spacingLarge),

        _buildPlaceOrderButton(),
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
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.inputRadius),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: TextField(
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.smallText,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.searchBiscuits,
            hintStyle: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.extraSmallText,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.secondaryTextColor,
              size: AppSizes.iconSmall,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSizes.paddingSmall,
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
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
        itemCount: _filters.length,
        separatorBuilder: (_, _) {
          return const SizedBox(width: AppSizes.spacingSmall);
        },
        itemBuilder: (context, index) {
          final bool isSelected = _selectedFilterIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 34,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLarge,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : const Color(0xFFEAF0F6),
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              ),
              child: Text(
                _filters[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.primaryTextColor,
                  fontSize: AppSizes.extraSmallText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // CART ITEMS
  // ============================================================

  Widget _buildCartItems() {
    if (_cartItems.isEmpty) {
      return _buildEmptyCart();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
      child: Column(
        children: [
          for (int index = 0; index < _cartItems.length; index++) ...[
            _CartItemCard(
              item: _cartItems[index],
              onIncrease: () {
                _increaseQuantity(index);
              },
              onDecrease: () {
                _decreaseQuantity(index);
              },
              onDelete: () {
                _removeItem(index);
              },
            ),

            if (index != _cartItems.length - 1)
              const SizedBox(height: AppSizes.spacingMedium),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY CART
  // ============================================================

  Widget _buildEmptyCart() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingExtraLarge),
      child: Column(
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 48,
            color: AppColors.secondaryTextColor,
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          const Text(
            'Your cart is empty',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.headingText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          const Text(
            'Add some products to place an order.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.smallText,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER SUMMARY
  // ============================================================

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.orderSummary,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.bodyText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          _SummaryRow(
            label: '${AppStrings.totalItems} ($_totalItems)',
            value: '₹${_subtotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          _SummaryRow(
            label: AppStrings.subtotal,
            value: '₹${_subtotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          _SummaryRow(
            label: AppStrings.discount,
            value: '-₹${_discount.toStringAsFixed(2)}',
            valueColor: AppColors.errorColor,
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          Container(height: 1, color: const Color(0xFFF0F0F0)),

          const SizedBox(height: AppSizes.spacingMedium),

          _SummaryRow(
            label: AppStrings.grandTotal,
            value: '₹${_grandTotal.toStringAsFixed(2)}',
            isGrandTotal: true,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PLACE ORDER
  // ============================================================

  Widget _buildPlaceOrderButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
      child: SizedBox(
        height: AppSizes.buttonHeight,
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _cartItems.isEmpty
              ? null
              : () {
                  Navigator.pushNamed(context, '/customer-order-status');
                },
          icon: const Icon(
            Icons.check_circle_outline,
            size: AppSizes.iconSmall,
          ),
          label: const Text(
            AppStrings.placeOrder,
            style: TextStyle(
              fontSize: AppSizes.smallText,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            disabledBackgroundColor: const Color(0xFFE0E0E0),
            foregroundColor: AppColors.whiteColor,
            disabledForegroundColor: AppColors.secondaryTextColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// CART ITEM CARD
// ================================================================

class _CartItemCard extends StatelessWidget {
  final _CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const _CartItemCard({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  double get _itemTotal {
    return item.price * item.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImagePlaceholder(),

          const SizedBox(width: AppSizes.spacingMedium),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.primaryTextColor,
                          fontSize: AppSizes.bodyText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.secondaryTextColor,
                        size: AppSizes.iconSmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 1),

                Text(
                  '${item.brand} ${item.size}',
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: AppSizes.extraSmallText,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingSmall),

                Text(
                  '₹${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppSizes.bodyText,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingSmall),

                Row(
                  children: [
                    _QuantityButton(icon: Icons.remove, onTap: onDecrease),

                    Container(
                      height: 28,
                      constraints: const BoxConstraints(minWidth: 34),
                      alignment: Alignment.center,
                      color: const Color(0xFFF3F5F7),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          color: AppColors.primaryTextColor,
                          fontSize: AppSizes.smallText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    _QuantityButton(icon: Icons.add, onTap: onIncrease),

                    const Spacer(),

                    Text(
                      '₹${_itemTotal.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: AppSizes.bodyText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: AppColors.borderColor),
      ),
    );
  }
}

// ================================================================
// QUANTITY BUTTON
// ================================================================

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(
            icon,
            color: AppColors.whiteColor,
            size: AppSizes.iconSmall,
          ),
        ),
      ),
    );
  }
}

// ================================================================
// SUMMARY ROW
// ================================================================

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isGrandTotal;

  const _SummaryRow({
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
              fontWeight: isGrandTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),

        Text(
          value,
          style: TextStyle(
            color:
                valueColor ??
                (isGrandTotal
                    ? AppColors.priceColor
                    : AppColors.primaryTextColor),
            fontSize: isGrandTotal
                ? AppSizes.bodyText
                : AppSizes.extraSmallText,
            fontWeight: isGrandTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// CART ITEM MODEL
// ================================================================

class _CartItem {
  final String name;
  final String brand;
  final String size;
  final double price;
  int quantity;

  _CartItem({
    required this.name,
    required this.brand,
    required this.size,
    required this.price,
    required this.quantity,
  });
}
