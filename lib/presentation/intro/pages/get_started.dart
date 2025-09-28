// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musicapp/common/widgets/button/basic_button_app.dart';
import 'package:musicapp/core/config/assets/app_images.dart';
import 'package:musicapp/core/config/assets/app_vectors.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';
import 'package:musicapp/presentation/choose_mode/pages/choose_mode.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.introBG),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Branded gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary, // brand green
                  Colors.transparent,
                  AppColors.secondary, // accent coral
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      AppVectors.logo,
                      height: 90,
                      color: Colors.white, // keeps logo visible on bg
                    ),
                  ),

                  const Spacer(),

                  // Headline
                  Text(
                    'Shop Smarter, Live Better',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: AppColors.textPrimaryDark, // adaptive
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Discover exclusive deals, explore trending products, and enjoy a seamless shopping experience all in one place.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimaryDark, // adaptive
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 36),

                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ChooseModePage(),
                          ),
                        );
                      },
                      title: 'Start Shopping',
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
}
