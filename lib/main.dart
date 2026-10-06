import 'package:flutter/material.dart';

// ============================================================
// OWNER SCREENS
// ============================================================

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
import 'screen/sub_categories_screen.dart' as owner_sub_categories;

// ============================================================
// CUSTOMER AUTHENTICATION
// ============================================================

import 'screen/customer_login_screen.dart';
import 'screen/customer_create_account_screen.dart';
import 'screen/otp_verification_screen.dart';
import 'screen/create_new_password_screen.dart';

// ============================================================
// CUSTOMER MODULE
// ============================================================

import 'screen/Customer/customer_home_screen.dart' as customer_home;
import 'screen/Customer/sub_categories_screen.dart' as customer_sub_categories;
import 'screen/Customer/product_listing_screen.dart'
    as customer_product_listing;
import 'screen/Customer/product_details_screen.dart'
    as customer_product_details;
import 'screen/Customer/cart_screen.dart' as customer_cart;
import 'screen/Customer/order_history_screen.dart' as customer_order_history;
import 'screen/Customer/order_details_screen.dart' as customer_order_details;
import 'screen/Customer/order_status_screen.dart' as customer_order_status;
import 'screen/Customer/profile_screen.dart' as customer_profile;
import 'screen/Customer/manage_profile_screen.dart' as customer_manage_profile;
import 'screen/Customer/my_address_screen.dart' as customer_address;

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

      // ========================================================
      // MAIN APP ENTRY POINT
      // ========================================================
      initialRoute: '/customer-login',

      routes: {
        // ========================================================
        // CUSTOMER AUTHENTICATION
        // ========================================================
        '/customer-login': (context) => const CustomerLoginScreen(),

        '/customer-create-account': (context) =>
            const CustomerCreateAccountScreen(),

        '/otp-verification': (context) => const OtpVerificationScreen(),

        '/create-new-password': (context) => const CreateNewPasswordScreen(),

        // ========================================================
        // CUSTOMER DASHBOARD
        // ========================================================
        '/customer-home': (context) => const customer_home.CustomerHomeScreen(),

        // ========================================================
        // CUSTOMER PRODUCT FLOW
        // ========================================================
        '/customer-sub-categories': (context) =>
            const customer_sub_categories.SubCategoriesScreen(),

        '/customer-product-listing': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          String? category;
          if (arguments is String) {
            category = arguments;
          } else if (arguments is Map) {
            category = arguments['category'] as String?;
          }
          return customer_product_listing.ProductListingScreen(
            category: category,
          );
        },

        '/customer-product-details': (context) =>
            const customer_product_details.ProductDetailsScreen(),

        // ========================================================
        // CUSTOMER CART
        // ========================================================
        '/customer-cart': (context) => const customer_cart.CartScreen(),

        // ========================================================
        // CUSTOMER ORDERS
        // ========================================================
        '/customer-orders': (context) =>
            const customer_order_history.OrderHistoryScreen(),

        '/customer-order-details': (context) =>
            const customer_order_details.OrderDetailsScreen(),

        '/customer-order-status': (context) =>
            const customer_order_status.OrderStatusScreen(),

        // ========================================================
        // CUSTOMER PROFILE
        // ========================================================
        '/customer-profile': (context) =>
            const customer_profile.ProfileScreen(),

        '/customer-manage-profile': (context) =>
            const customer_manage_profile.ManageProfileScreen(),

        '/customer-address': (context) =>
            const customer_address.MyAddressScreen(),

        // ========================================================
        // OWNER AUTHENTICATION
        // ========================================================
        '/owner-login': (context) => const OwnerLoginScreen(),

        // ========================================================
        // OWNER HOME
        // ========================================================
        '/owner-home': (context) => const OwnerHomeScreen(),

        // ========================================================
        // OWNER PRODUCTS
        // ========================================================
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
        '/sub-categories': (context) =>
            const owner_sub_categories.SubCategoriesScreen(),

        // ========================================================
        // OWNER VENDORS
        // ========================================================
        '/add-vendor': (context) => const AddVendorScreen(),

        '/vendor-list': (context) => const VendorListScreen(),

        '/vendor-details': (context) {
          final vendorName =
              ModalRoute.of(context)?.settings.arguments as String?;

          return VendorDetailsScreen(vendorName: vendorName ?? 'Britannia');
        },

        '/vendor-order': (context) => const VendorOrderGenerationScreen(),

        // ========================================================
        // OWNER ORDERS
        // ========================================================
        '/order-history': (context) => const OwnerOrderHistoryScreen(),

        '/order-details': (context) => const OwnerOrderDetailsScreen(),

        '/order-success': (context) => const OwnerOrderSuccessScreen(),

        // ========================================================
        // OWNER CUSTOMER MANAGEMENT
        // ========================================================
        '/customer-management': (context) => const CustomerManagementScreen(),

        // ========================================================
        // OWNER PROFILE
        // ========================================================
        '/owner-profile': (context) => const OwnerProfileScreen(),

        // ========================================================
        // OWNER OTHER SCREENS
        // ========================================================
        '/about': (context) => const AboutScreen(),

        '/help-support': (context) => const HelpSupportScreen(),
      },
    );
  }
}
