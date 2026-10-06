import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_text_size.dart';

class CustomerCreateAccountScreen extends StatefulWidget {
  const CustomerCreateAccountScreen({super.key});

  @override
  State<CustomerCreateAccountScreen> createState() =>
      _CustomerCreateAccountScreenState();
}

class _CustomerCreateAccountScreenState
    extends State<CustomerCreateAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
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
                'Welcome!',
                style: TextStyle(
                  fontSize: AppSizes.titleText,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),

              const SizedBox(height: AppSizes.spacingSmall),

              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: AppSizes.bodyText,
                  color: AppColors.secondaryTextColor,
                ),
              ),

              const SizedBox(height: AppSizes.spacingExtraLarge),

              _buildAccountForm(),

              const SizedBox(height: AppSizes.spacingSmall),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontSize: AppSizes.bodyText,
                        color: AppColors.secondaryTextColor,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.spacingSmall),

              _buildCreateAccountButton(),
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

  Widget _buildAccountForm() {
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
            'Name',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              color: AppColors.secondaryTextColor,
            ),
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          _buildTextField(
            controller: nameController,
            hintText: 'Enter your name',
            icon: Icons.person_outline,
          ),

          const SizedBox(height: AppSizes.spacingMedium),

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

  Widget _buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
        ),
        child: Text(
          'Create Account',
          style: TextStyle(
            fontSize: AppSizes.mediumText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
