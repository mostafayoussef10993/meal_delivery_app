import 'package:musicapp/common/cubits/cart_cubit.dart';
import 'package:musicapp/data/models/meal/meal.dart';

class AddToCartUseCase {
  final CartCubit cartCubit;

  AddToCartUseCase(this.cartCubit);

  void call(Meal meal) {
    cartCubit.addToCart(meal);
  }
}
