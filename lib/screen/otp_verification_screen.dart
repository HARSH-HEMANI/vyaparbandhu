import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final focusNode in otpFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  void _moveToNextField(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      otpFocusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  void _verifyCode() {
    Navigator.pushNamed(context, '/create-new-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingLarge,
            vertical: AppSizes.paddingExtraLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryTextColor,
                  ),
                ),
              ),
              _buildLogo(),
              const SizedBox(height: AppSizes.spacingExtraLarge),
              Text(
                'Check Your Email',
                style: TextStyle(
                  fontSize: AppSizes.titleText,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              Text(
                'Verify the Code sent to your email',
                style: TextStyle(
                  fontSize: AppSizes.bodyText,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(height: AppSizes.spacingExtraLarge),
              _buildOtpContainer(),
              const SizedBox(height: AppSizes.spacingSmall),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      fontSize: AppSizes.bodyText,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        AppImages.logo,
        width: 230,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildOtpContainer() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter Code Here',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              color: AppColors.secondaryTextColor,
            ),
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 42,
                height: 48,
                child: TextField(
                  controller: otpControllers[index],
                  focusNode: otpFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: TextStyle(
                    fontSize: AppSizes.mediumText,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryTextColor,
                  ),
                  onChanged: (value) {
                    _moveToNextField(index, value);
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '_',
                    hintStyle: TextStyle(color: AppColors.hintTextColor),
                    filled: true,
                    fillColor: AppColors.inputBackgroundColor,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: _verifyCode,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verify Code',
              style: TextStyle(
                fontSize: AppSizes.mediumText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppSizes.spacingMedium),
            const Icon(Icons.arrow_forward, size: AppSizes.iconMedium),
          ],
        ),
      ),
    );
  }
}
