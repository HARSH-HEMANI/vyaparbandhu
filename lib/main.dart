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
        '/owner-login': (context) => const OwnerLoginScreen(),
        '/owner-home': (context) => const OwnerHomeScreen(),
        '/add-product': (context) => const AddProductScreen(),
        '/add-vendor': (context) => const AddVendorScreen(),
        '/vendor-list': (context) => const VendorListScreen(),
        '/vendor-details': (context) {
          final vendorName =
              ModalRoute.of(context)?.settings.arguments as String?;

          return VendorDetailsScreen(vendorName: vendorName ?? 'Britannia');
        },
        '/vendor-order': (context) => const VendorOrderGenerationScreen(),
        '/order-history': (context) => const OwnerOrderHistoryScreen(),
        '/order-details': (context) => const OwnerOrderDetailsScreen(),
        '/customer-management': (context) => const CustomerManagementScreen(),
        '/owner-profile': (context) => const OwnerProfileScreen(),
        '/about': (context) => const AboutScreen(),
        '/help-support': (context) => const HelpSupportScreen(),
        '/order-success': (context) => const OwnerOrderSuccessScreen(),
        '/product-details': (context) => const ProductDetailsScreen(),
        '/product-listing': (context) => const ProductListingScreen(),
        '/sub-categories': (context) => const SubCategoriesScreen(),
      },
    );
  }
}
