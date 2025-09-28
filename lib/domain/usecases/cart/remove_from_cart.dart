// domain/usecases/cart/remove_from_cart.dart
import 'package:musicapp/common/cubits/cart_cubit.dart';

class RemoveFromCartUseCase {
  final CartCubit cartCubit;

  RemoveFromCartUseCase(this.cartCubit);

  void call(int productId) {
    cartCubit.removeFromCart(productId);
  }
}
