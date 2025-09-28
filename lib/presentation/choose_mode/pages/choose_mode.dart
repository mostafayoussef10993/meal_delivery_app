// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/common/widgets/button/basic_button_app.dart';
import 'package:musicapp/core/config/assets/app_images.dart';
import 'package:musicapp/core/config/assets/app_vectors.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';
import 'package:musicapp/presentation/auth/pages/signup_or_signin.dart';
import 'package:musicapp/presentation/choose_mode/bloc/theme_cubit.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chooseModeBG),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient overlay for brand feel
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  Colors.transparent,
                  AppColors.secondary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  // Logo
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      AppVectors.logo,
                      height: 90,
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(),

                  // Title
                  Text(
                    'Choose Your Style',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: AppColors.textPrimaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Switch between Light and Dark mode to personalize your shopping experience.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryDark,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // Mode selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildModeOption(
                        context,
                        icon: AppVectors.moon,
                        label: 'Dark Mode',
                        onTap: () => context.read<ThemeCubit>().updateTheme(
                          ThemeMode.dark,
                        ),
                      ),
                      const SizedBox(width: 40),
                      _buildModeOption(
                        context,
                        icon: AppVectors.sun,
                        label: 'Light Mode',
                        onTap: () => context.read<ThemeCubit>().updateTheme(
                          ThemeMode.light,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // CTA button
                  SizedBox(
                    width: double.infinity,
                    child: BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SignupOrSigninPage(),
                          ),
                        );
                      },
                      title: 'Continue',
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeOption(
    BuildContext context, {
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: AppColors.darkBackground.withOpacity(0.6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.7),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    height: 36,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
      ],
    );
  }
}
