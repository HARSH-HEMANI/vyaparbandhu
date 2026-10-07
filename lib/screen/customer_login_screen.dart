import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ============================================================
  // CUSTOMER LOGIN
  // ============================================================

  void _login() {
    Navigator.pushReplacementNamed(context, '/customer-home');
  }

  // ============================================================
  // CUSTOMER CREATE ACCOUNT
  // ============================================================

  void _createAccount() {
    Navigator.pushNamed(context, '/customer-create-account');
  }

  // ============================================================
  // OWNER LOGIN
  // ============================================================

  void _ownerLogin() {
    Navigator.pushReplacementNamed(context, '/owner-login');
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

              const SizedBox(height: AppSizes.spacingLarge),

              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: AppSizes.titleText,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),

              const SizedBox(height: AppSizes.spacingSmall),

              Text(
                'Sign in to continue shopping',
                style: TextStyle(
                  fontSize: AppSizes.bodyText,
                  color: AppColors.secondaryTextColor,
                ),
              ),

              const SizedBox(height: AppSizes.spacingExtraLarge),

              _buildLoginForm(),

              const SizedBox(height: AppSizes.spacingSmall),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/otp-verification');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: AppSizes.bodyText,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.spacingSmall),

              _buildLoginButton(),

              const SizedBox(height: AppSizes.spacingLarge),

              _buildOrDivider(),

              const SizedBox(height: AppSizes.spacingLarge),

              _buildCreateAccountButton(),

              const SizedBox(height: AppSizes.spacingLarge),

              // ==================================================
              // OWNER LOGIN LINK
              // ==================================================
              Center(
                child: TextButton(
                  onPressed: _ownerLogin,
                  child: Text(
                    'Owner? Login',
                    style: TextStyle(
                      fontSize: AppSizes.bodyText,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // LOGO
  // ============================================================

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

  // ============================================================
  // LOGIN FORM
  // ============================================================

  Widget _buildLoginForm() {
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
            'Email Address',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              color: AppColors.secondaryTextColor,
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          _buildTextField(
            controller: emailController,
            hintText: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: AppSizes.spacingMedium),

          Text(
            'Password',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              color: AppColors.secondaryTextColor,
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          _buildTextField(
            controller: passwordController,
            hintText: 'Enter your password',
            icon: Icons.lock_outline,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.secondaryTextColor,
                size: AppSizes.iconMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: AppSizes.inputHeight,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
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
            icon,
            color: AppColors.secondaryTextColor,
            size: AppSizes.iconMedium,
          ),
          suffixIcon: suffixIcon,
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

  // ============================================================
  // LOGIN BUTTON
  // ============================================================

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

  // ============================================================
  // OR DIVIDER
  // ============================================================

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.borderColor)),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
          ),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryTextColor,
            ),
          ),
        ),

        Expanded(child: Divider(color: AppColors.borderColor)),
      ],
    );
  }

  // ============================================================
  // CREATE ACCOUNT BUTTON
  // ============================================================

  Widget _buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: _createAccount,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondaryTextColor,
          side: BorderSide(color: AppColors.borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
        ),
        child: Text(
          'Create New Account',
          style: TextStyle(
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
