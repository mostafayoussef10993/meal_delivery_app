// presentation/products/widgets/add_to_cart_button.dart
import 'package:flutter/material.dart';
import 'package:musicapp/data/models/product/product.dart';
import 'package:musicapp/domain/usecases/cart/add_to_cart.dart';
import 'package:musicapp/service_locator.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;

  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // solid primary button
          foregroundColor: Colors.white, // icon and text color
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.shopping_cart),
        label: const Text(
          "Add to Cart",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          sl<AddToCartUseCase>().call(product);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Added to cart")));
        },
      ),
    );
  }
}
