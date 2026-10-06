import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
// import '../resources/app_strings.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int currentIndex = 0;

  final List<String> categories = [
    'Biscuits & Cookies',
    'Drinks',
    'Packed Food',
    'Personal Care',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        titleSpacing: AppSizes.paddingLarge,

        title: Text(
          'Hello, Jay',
          style: TextStyle(
            fontSize: AppSizes.titleText,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTextColor,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.paddingLarge),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.inputBackgroundColor,
              child: Icon(
                Icons.person_outline,
                color: AppColors.primaryColor,
                size: AppSizes.iconMedium,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),

            const SizedBox(height: AppSizes.spacingLarge),

            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    title: 'Browse Products',
                    icon: Icons.shopping_bag_outlined,
                  ),
                ),
                const SizedBox(width: AppSizes.spacingMedium),
                Expanded(
                  child: _buildActionCard(
                    title: 'View Cart',
                    icon: Icons.shopping_cart_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spacingExtraLarge),

            Text(
              'Categories',
              style: TextStyle(
                fontSize: AppSizes.headingText,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor,
              ),
            ),

            const SizedBox(height: AppSizes.spacingMedium),

            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(categories[index]);
                },
              ),
            ),

            const SizedBox(height: AppSizes.spacingExtraLarge),

            Text(
              'Popular Products',
              style: TextStyle(
                fontSize: AppSizes.headingText,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor,
              ),
            ),

            const SizedBox(height: AppSizes.spacingMedium),

            _buildProductCard('Good Day Cashew', '₹120'),

            const SizedBox(height: AppSizes.spacingMedium),

            _buildProductCard('Parle-G Biscuits', '₹60'),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: AppSizes.inputHeight,
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search products',
          hintStyle: TextStyle(
            color: AppColors.hintTextColor,
            fontSize: AppSizes.bodyText,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.secondaryTextColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSizes.paddingMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({required String title, required IconData icon}) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: AppSizes.iconLarge),

          const SizedBox(height: AppSizes.spacingSmall),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String category) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: AppSizes.spacingMedium),
      padding: const EdgeInsets.all(AppSizes.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            AppImages.placeholder,
            height: 55,
            width: 55,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          Text(
            category,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: AppSizes.smallText,
              color: AppColors.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String productName, String price) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Image.network(
            AppImages.placeholder,
            height: AppSizes.productImageSize,
            width: AppSizes.productImageSize,
            fit: BoxFit.cover,
          ),

          const SizedBox(width: AppSizes.spacingMedium),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryTextColor,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingSmall),

                Text(
                  price,
                  style: TextStyle(
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.bold,
                    color: AppColors.priceColor,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios,
            size: AppSizes.iconSmall,
            color: AppColors.secondaryTextColor,
          ),
        ],
      ),
    );
  }
}
