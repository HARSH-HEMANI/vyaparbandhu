import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_size.dart';
import '../widgets/bottom_nav_bar.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int _currentIndex = 3;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How can I place an order?',
      'answer':
          'Browse products, select the required quantity and add them to your order.',
    },
    {
      'question': 'How can I track my order?',
      'answer': 'You can check your order status from the Orders section.',
    },
    {
      'question': 'How can I update my profile?',
      'answer': 'Open My Profile and select the relevant profile option.',
    },
    {
      'question': 'How can I contact support?',
      'answer':
          'You can contact our support team during the available support hours.',
    },
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSupportHeader(),
            const SizedBox(height: AppSizes.spacingExtraLarge),
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.headingText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSizes.spacingMedium),
            _buildFaqList(),
            const SizedBox(height: AppSizes.spacingExtraLarge),
            _buildContactCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        isOwner: true,
      ),
    );
  }

  Widget _buildSupportHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: const Column(
        children: [
          Icon(Icons.support_agent, color: AppColors.primaryColor, size: 42),
          SizedBox(height: AppSizes.spacingMedium),
          Text(
            'How can we help you?',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.titleText,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSizes.spacingSmall),
          Text(
            'Find answers to frequently asked questions',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: AppSizes.bodyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqList() {
    return Column(
      children: _faqs.map((faq) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppSizes.spacingSmall),
          elevation: AppSizes.cardElevation,
          color: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            side: const BorderSide(color: AppColors.borderColor),
          ),
          child: ExpansionTile(
            iconColor: AppColors.primaryColor,
            collapsedIconColor: AppColors.secondaryTextColor,
            title: Text(
              faq['question']!,
              style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppSizes.bodyText,
                fontWeight: FontWeight.w500,
              ),
            ),
            childrenPadding: const EdgeInsets.fromLTRB(
              AppSizes.paddingLarge,
              0,
              AppSizes.paddingLarge,
              AppSizes.paddingMedium,
            ),
            children: [
              Text(
                faq['answer']!,
                style: const TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: AppSizes.bodyText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.headingText,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                color: AppColors.primaryColor,
                size: AppSizes.iconMedium,
              ),
              SizedBox(width: AppSizes.spacingMedium),
              Text(
                '+91 82002 23933',
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: AppSizes.bodyText,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppColors.primaryColor,
                size: AppSizes.iconMedium,
              ),
              SizedBox(width: AppSizes.spacingMedium),
              Text(
                '10 A.M. - 6 P.M.',
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: AppSizes.bodyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
