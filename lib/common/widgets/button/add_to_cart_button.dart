import 'package:flutter/material.dart';
import 'package:musicapp/data/models/meal/meal.dart';
import 'package:musicapp/domain/usecases/cart/add_to_cart.dart';
import 'package:musicapp/service_locator.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  final Meal meal;

  const AddToCartButton({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 3,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.shopping_cart),
      label: const Text(
        "Add to Cart",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        sl<AddToCartUseCase>().call(meal);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Added to cart")));
      },
    );
  }
}
