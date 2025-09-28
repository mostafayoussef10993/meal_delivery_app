import 'package:flutter/material.dart';
import 'package:musicapp/domain/usecases/cart/remove_from_cart.dart';
import 'package:musicapp/service_locator.dart';

class RemoveFromCartButton extends StatelessWidget {
  final int productId;

  const RemoveFromCartButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.remove_shopping_cart),
      color: Colors.red, // define a red color in AppColors
      tooltip: 'Remove from cart',
      onPressed: () {
        sl<RemoveFromCartUseCase>().call(productId);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Removed from cart")));
      },
    );
  }
}
