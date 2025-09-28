// domain/usecases/wishlist/remove_from_wishlist.dart
import 'package:musicapp/common/cubits/wishlist_cubit.dart';

class RemoveFromWishlistUseCase {
  final WishlistCubit wishlistCubit;

  RemoveFromWishlistUseCase(this.wishlistCubit);

  void call(int productId) {
    wishlistCubit.removeFromWishlist(productId);
  }
}
