// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:musicapp/core/config/assets/app_images.dart';

class SigninSignupBox extends StatelessWidget {
  const SigninSignupBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // fixed width
      height: 120, // fixed height
      decoration: BoxDecoration(
        color: Colors.white, // optional background color
        borderRadius: BorderRadius.circular(16), // circular corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge, // ensures image respects borderRadius
      child: Image.asset(
        AppImages.signuporsignin,
        fit: BoxFit.cover, // fills nicely inside
      ),
    );
  }
}
