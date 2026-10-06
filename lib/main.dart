import 'package:flutter/material.dart';
// import 'screen/Customer/customer_home_screen.dart';
// import 'screen/Customer/sub_categories_screen.dart';
// import 'screen/Customer/product_listing_screen.dart';
// import 'screen/Customer/product_details_screen.dart';
// import 'screen/Customer/order_history_screen.dart';
// import 'screen/Customer/order_details_screen.dart';
// import 'screen/Customer/cart_screen.dart';
// import 'screen/Customer/order_status_screen.dart';
// import 'screen/Customer/manage_profile_screen.dart';
// import 'screen/Customer/profile_screen.dart';
import 'screen/Customer/my_address_screen.dart';
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
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      home: const MyAddressScreen(),    );
  }
}
