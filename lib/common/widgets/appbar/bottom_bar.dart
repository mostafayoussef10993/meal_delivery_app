// presentation/common/widgets/bottom_nav_bar.dart
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:musicapp/presentation/cart/pages/cart_page.dart';
import 'package:musicapp/presentation/profile/pages/profile.dart';
import 'package:musicapp/presentation/whishlist/pages/wishlist_page.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.lightBackground, // using app colors
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 🔹 Profile Button
          _BottomBarItem(
            icon: Icons.person,
            iconColor: AppColors.textPrimaryLight,
            backgroundColor: AppColors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
          ),

          // 🔹 Cart Button
          _BottomBarItem(
            icon: Icons.shopping_cart,
            iconColor: AppColors.textPrimaryLight,
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage()),
              );
            },
          ),

          // 🔹 Wishlist Button
          _BottomBarItem(
            icon: Icons.favorite,
            iconColor: AppColors.primary,
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WishlistPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ✅ Reusable BottomBar Item Widget
class _BottomBarItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: backgroundColor,
        child: Icon(icon, color: iconColor, size: 26),
      ),
    );
  }
}
