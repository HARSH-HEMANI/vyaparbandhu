import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _login() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/customer-login',
      (route) => false,
    );
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
              _buildLogo(),
              const SizedBox(height: AppSizes.spacingExtraLarge),
              Text(
                'Create New Password',
                style: TextStyle(
                  fontSize: AppSizes.titleText,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              Text(
                'Forgot Password? No Worries...',
                style: TextStyle(
                  fontSize: AppSizes.bodyText,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(height: AppSizes.spacingExtraLarge),
              _buildPasswordForm(),
              const SizedBox(height: AppSizes.spacingMedium),
              _buildRememberPassword(),
              const SizedBox(height: AppSizes.spacingLarge),
              _buildLoginButton(),
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

  Widget _buildPasswordForm() {
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
            'New Password',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              color: AppColors.secondaryTextColor,
            ),
          ),
          const SizedBox(height: AppSizes.spacingSmall),
          _buildPasswordField(
            controller: passwordController,
            hintText: 'Enter new password',
            obscureText: obscurePassword,
            onToggle: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Text(
            'Re-enter New Password',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              color: AppColors.secondaryTextColor,
            ),
          ),
          const SizedBox(height: AppSizes.spacingSmall),
          _buildPasswordField(
            controller: confirmPasswordController,
            hintText: 'Re-enter new password',
            obscureText: obscureConfirmPassword,
            onToggle: () {
              setState(() {
                obscureConfirmPassword = !obscureConfirmPassword;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return SizedBox(
      height: AppSizes.inputHeight,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: AppSizes.bodyText,
          color: AppColors.primaryTextColor,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.inputBackgroundColor,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: AppSizes.bodyText,
            color: AppColors.hintTextColor,
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: AppColors.secondaryTextColor,
            size: AppSizes.iconMedium,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.secondaryTextColor,
              size: AppSizes.iconMedium,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
          ),
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
  }

  Widget _buildRememberPassword() {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
          activeColor: AppColors.primaryColor,
          visualDensity: VisualDensity.compact,
        ),
        Text(
          'Remember Password?',
          style: TextStyle(
            fontSize: AppSizes.bodyText,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: _login,
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
              'Login',
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
