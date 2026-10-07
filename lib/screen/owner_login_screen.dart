import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';

class OwnerLoginScreen extends StatefulWidget {
  const OwnerLoginScreen({super.key});

  @override
  State<OwnerLoginScreen> createState() => _OwnerLoginScreenState();
}

class _OwnerLoginScreenState extends State<OwnerLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                'Welcome Owner!',
                style: TextStyle(
                  fontSize: AppSizes.titleText,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),

              const SizedBox(height: AppSizes.spacingSmall),

              Text(
                'Sign in to your shop companion',
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

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/customer-login');
                  },
                  child: Text(
                    'Customer? Login',
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

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/owner-home');
        },
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
