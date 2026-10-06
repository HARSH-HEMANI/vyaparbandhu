import 'package:flutter/material.dart';

import 'screen/owner_login_screen.dart';
import 'screen/owner_home_screen.dart';
import 'screen/add_product_screen.dart';
import 'screen/add_vendor_screen.dart';
import 'screen/vendor_list_screen.dart';
import 'screen/vendor_details_screen.dart';
import 'screen/vendor_order_generation_screen.dart';
import 'screen/owner_order_history_screen.dart';
import 'screen/owner_order_details_screen.dart';
import 'screen/customer_management_screen.dart';
import 'screen/owner_profile_screen.dart';
import 'screen/about_screen.dart';
import 'screen/help_support_screen.dart';
import 'screen/owner_order_success_screen.dart';
import 'screen/product_details_screen.dart';
import 'screen/product_listing_screen.dart';
import 'screen/sub_categories_screen.dart';
import 'screen/customer_login_screen.dart';
import 'screen/customer_home_screen.dart';
import 'screen/customer_create_account_screen.dart';
import 'screen/otp_verification_screen.dart';
import 'screen/create_new_password_screen.dart';
import 'screen/customer_order_screen.dart';
import 'screen/customer_cart_screen.dart';
import 'screen/customer_profile_screen.dart';

void main() {
  runApp(const VyaparBandhuApp());
}

class VyaparBandhuApp extends StatelessWidget {
  const VyaparBandhuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VyaparBandhu',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1688C7)),
      ),
      initialRoute: '/owner-login',
      routes: {
        // ------------------------------------------------------------
        // OWNER AUTHENTICATION
        // ------------------------------------------------------------
        '/owner-login': (context) => const OwnerLoginScreen(),

        // ------------------------------------------------------------
        // OWNER HOME
        // ------------------------------------------------------------
        '/owner-home': (context) => const OwnerHomeScreen(),

        // ------------------------------------------------------------
        // CUSTOMER AUTHENTICATION
        // ------------------------------------------------------------
        '/customer-login': (context) => const CustomerLoginScreen(),

        '/customer-create-account': (context) =>
            const CustomerCreateAccountScreen(),

        '/otp-verification': (context) => const OtpVerificationScreen(),

        '/create-new-password': (context) => const CreateNewPasswordScreen(),

        // ------------------------------------------------------------
        // CUSTOMER HOME
        // ------------------------------------------------------------
        '/customer-home': (context) => const CustomerHomeScreen(),

        // ------------------------------------------------------------
        // CUSTOMER BOTTOM NAVIGATION
        // ------------------------------------------------------------
        '/customer-orders': (context) => const CustomerOrderScreen(),

        '/customer-cart': (context) => const CustomerCartScreen(),

        '/customer-profile': (context) => const CustomerProfileScreen(),

        // ------------------------------------------------------------
        // PRODUCTS
        // ------------------------------------------------------------
        '/add-product': (context) => const AddProductScreen(),

        '/product-listing': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;

          String? category;
          bool isOwner = true;

          if (arguments is String) {
            category = arguments;
            isOwner = false;
          } else if (arguments is Map) {
            category = arguments['category'] as String?;
            isOwner = arguments['isOwner'] as bool? ?? true;
          }

          return ProductListingScreen(category: category, isOwner: isOwner);
        },

        '/product-details': (context) => const ProductDetailsScreen(),

        // ------------------------------------------------------------
        // VENDORS
        // ------------------------------------------------------------
        '/add-vendor': (context) => const AddVendorScreen(),

        '/vendor-list': (context) => const VendorListScreen(),

        '/vendor-details': (context) {
          final vendorName =
              ModalRoute.of(context)?.settings.arguments as String?;

          return VendorDetailsScreen(vendorName: vendorName ?? 'Britannia');
        },

        '/vendor-order': (context) => const VendorOrderGenerationScreen(),

        // ------------------------------------------------------------
        // OWNER ORDERS
        // ------------------------------------------------------------
        '/order-history': (context) => const OwnerOrderHistoryScreen(),

        '/order-details': (context) => const OwnerOrderDetailsScreen(),

        '/order-success': (context) => const OwnerOrderSuccessScreen(),

        // ------------------------------------------------------------
        // CUSTOMER MANAGEMENT
        // ------------------------------------------------------------
        '/customer-management': (context) => const CustomerManagementScreen(),

        // ------------------------------------------------------------
        // OWNER PROFILE
        // ------------------------------------------------------------
        '/owner-profile': (context) => const OwnerProfileScreen(),

        // ------------------------------------------------------------
        // OTHER OWNER SCREENS
        // ------------------------------------------------------------
        '/about': (context) => const AboutScreen(),

        '/help-support': (context) => const HelpSupportScreen(),

        // ------------------------------------------------------------
        // CUSTOMER CATEGORIES
        // ------------------------------------------------------------
        '/sub-categories': (context) => const SubCategoriesScreen(),
      },
    );
  }
}
