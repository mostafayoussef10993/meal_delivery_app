import 'package:musicapp/common/cubits/cart_cubit.dart';

class RemoveFromCartUseCase {
  final CartCubit cartCubit;

  RemoveFromCartUseCase(this.cartCubit);

  void call(String mealId) {
    cartCubit.removeFromCart(mealId);
  }
}
