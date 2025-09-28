import 'package:musicapp/common/cubits/wishlist_cubit.dart';
import 'package:musicapp/data/models/product/product.dart';

class AddToWishlistUseCase {
  final WishlistCubit wishlistCubit;

  AddToWishlistUseCase(this.wishlistCubit);

  void call(Product product) {
    wishlistCubit.addToWishlist(product);
  }
}
