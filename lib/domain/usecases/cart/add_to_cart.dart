import 'package:musicapp/common/cubits/cart_cubit.dart';
import 'package:musicapp/data/models/product/product.dart';

class AddToCartUseCase {
  final CartCubit cartCubit;

  AddToCartUseCase(this.cartCubit);

  void call(Product product) {
    cartCubit.addToCart(product);
  }
}
