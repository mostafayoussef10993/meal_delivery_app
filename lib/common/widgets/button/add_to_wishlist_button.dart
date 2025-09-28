// presentation/products/widgets/add_to_wishlist_button.dart
import 'package:flutter/material.dart';
import 'package:musicapp/data/models/product/product.dart';
import 'package:musicapp/domain/usecases/whishlist/add_to_wishlist.dart';
import 'package:musicapp/service_locator.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';

class AddToWishlistButton extends StatelessWidget {
  final Product product;

  const AddToWishlistButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBackground, // subtle background
          foregroundColor: AppColors.primary, // heart icon & text color
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
        icon: const Icon(Icons.favorite_border),
        label: const Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          sl<AddToWishlistUseCase>().call(product);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Added to wishlist")));
        },
      ),
    );
  }
}
