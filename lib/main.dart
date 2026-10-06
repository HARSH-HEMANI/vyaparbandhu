import 'package:flutter/material.dart';
import 'screen/customer_home_screen.dart';

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

      home: const CustomerHomeScreen(),
    );
  }
}
