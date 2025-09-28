// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musicapp/common/widgets/appbar/app_bar.dart';
import 'package:musicapp/common/widgets/button/basic_button_app.dart';
import 'package:musicapp/common/widgets/button/helpers/is_dark_mode.dart';
import 'package:musicapp/core/config/assets/app_images.dart';
import 'package:musicapp/core/config/assets/app_vectors.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';
import 'package:musicapp/presentation/auth/pages/signin.dart';
import 'package:musicapp/presentation/auth/pages/signup.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Custom app bar
          const BasicAppBar(),

          // Background patterns
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.topPattern,
              color: AppColors.accent.withOpacity(0.3),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.bottomPattern,
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImages.authBG,
              opacity: const AlwaysStoppedAnimation(0.6),
            ),
          ),

          // Main content
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  SvgPicture.asset(AppVectors.logo, height: 90),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                    'Welcome to ShopEasy',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryDark,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Your one-stop shop for exclusive deals and trending products. Create an account or sign in to get started.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryDark,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignupPage(),
                              ),
                            );
                          },
                          title: 'Register',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SigninPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign in',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
