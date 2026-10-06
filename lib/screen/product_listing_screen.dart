import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  int _currentIndex = 0;
  int _selectedFilter = 0;

  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = ['All', 'Popular', 'Britannia', 'Parle'];

  final List<Map<String, String>> _products = [
    {
      'name': 'Parle-G Gold',
      'brand': 'Parle',
      'price': '₹45',
      'mrp': '₹50',
      'size': '200 g',
    },
    {
      'name': 'Good Day',
      'brand': 'Britannia',
      'price': '₹80',
      'mrp': '₹90',
      'size': '420 g',
    },
    {
      'name': 'Oreo Original',
      'brand': 'Cadbury',
      'price': '₹25',
      'mrp': '₹30',
      'size': '89 g',
    },
    {
      'name': 'Dark Fantasy',
      'brand': 'Sunfeast',
      'price': '₹45',
      'mrp': '₹50',
      'size': '150 g',
    },
    {
      'name': 'Marie Light',
      'brand': 'Britannia',
      'price': '₹35',
      'mrp': '₹40',
      'size': '100 g',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  List<Map<String, String>> _getFilteredProducts() {
    final searchText = _searchController.text.trim().toLowerCase();

    List<Map<String, String>> products = _products;

    if (_selectedFilter == 2) {
      products = products
          .where((product) => product['brand'] == 'Britannia')
          .toList();
    } else if (_selectedFilter == 3) {
      products = products
          .where((product) => product['brand'] == 'Parle')
          .toList();
    }

    if (searchText.isNotEmpty) {
      products = products.where((product) {
        return product['name']!.toLowerCase().contains(searchText) ||
            product['brand']!.toLowerCase().contains(searchText);
      }).toList();
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final products = _getFilteredProducts();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        toolbarHeight: 48,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: AppSizes.iconMedium,
          ),
        ),
        title: const Text(
          'Biscuits & Cookies',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterList(),
          const SizedBox(height: AppSizes.spacingSmall),
          Expanded(
            child: products.isEmpty
                ? _buildEmptyState()
                : _buildProductList(products),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        isOwner: true,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingMedium,
        AppSizes.paddingMedium,
        AppSizes.paddingMedium,
        AppSizes.paddingSmall,
      ),
      child: SizedBox(
        height: 44,
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {});
          },
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.bodyText,
          ),
          decoration: InputDecoration(
            hintText: 'Search biscuits and cookies',
            hintStyle: const TextStyle(
              color: AppColors.hintTextColor,
              fontSize: AppSizes.smallText,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.secondaryTextColor,
              size: AppSizes.iconMedium,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.secondaryTextColor,
                    ),
                  )
                : null,
            filled: true,
            fillColor: AppColors.whiteColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
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
      ),
    );
  }

  Widget _buildFilterList() {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final bool selected = _selectedFilter == index;

          return Padding(
            padding: const EdgeInsets.only(right: AppSizes.spacingSmall),
            child: ChoiceChip(
              label: Text(_filters[index]),
              selected: selected,
              onSelected: (value) {
                setState(() {
                  _selectedFilter = index;
                });
              },
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall,
                vertical: 2,
              ),
              labelStyle: TextStyle(
                color: selected
                    ? AppColors.whiteColor
                    : AppColors.primaryTextColor,
                fontSize: AppSizes.smallText,
                fontWeight: FontWeight.w500,
              ),
              selectedColor: AppColors.primaryColor,
              backgroundColor: const Color(0xFFEFF3F7),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList(List<Map<String, String>> products) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingMedium,
        0,
        AppSizes.paddingMedium,
        AppSizes.paddingLarge,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
      color: AppColors.cardColor,
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProductImage(),
            const SizedBox(width: AppSizes.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: AppSizes.mediumText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingSmall),
                  Text(
                    product['brand']!,
                    style: const TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: AppSizes.smallText,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingSmall),
                  Row(
                    children: [
                      Text(
                        product['price']!,
                        style: const TextStyle(
                          color: AppColors.priceColor,
                          fontSize: AppSizes.bodyText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacingSmall),
                      Text(
                        product['mrp']!,
                        style: const TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: AppSizes.smallText,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.spacingSmall),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 54,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () {
                      _showMessage('${product['name']} added to order');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusSmall,
                        ),
                      ),
                    ),
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                        fontSize: AppSizes.smallText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spacingSmall),
                _buildSizeDropdown(product['size']!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeDropdown(String selectedSize) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedSize,
        isDense: true,
        icon: const Icon(Icons.keyboard_arrow_down, size: 16),
        style: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppSizes.smallText,
        ),
        items: <String>{selectedSize, '100 g', '200 g', '500 g'}.map((size) {
          return DropdownMenuItem<String>(value: size, child: Text(size));
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 72,
      height: 78,
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Image.network(
          AppImages.placeholder,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_outlined,
              color: AppColors.secondaryTextColor,
              size: AppSizes.iconLarge,
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48, color: AppColors.secondaryTextColor),
          SizedBox(height: AppSizes.spacingMedium),
          Text(
            'No products found',
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.bodyText,
            ),
          ),
        ],
      ),
    );
  }
}
