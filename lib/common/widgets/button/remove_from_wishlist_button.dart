// presentation/products/widgets/remove_from_wishlist_button.dart
import 'package:flutter/material.dart';
import 'package:musicapp/domain/usecases/whishlist/remove_from_wishlist.dart';
import 'package:musicapp/service_locator.dart';

class RemoveFromWishlistButton extends StatelessWidget {
  final int productId;
  const RemoveFromWishlistButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () {
        sl<RemoveFromWishlistUseCase>().call(productId);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Removed from wishlist")));
      },
    );
  }
}
