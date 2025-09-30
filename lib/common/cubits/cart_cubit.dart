import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:musicapp/data/models/meal/meal.dart';

class CartCubit extends HydratedCubit<List<Meal>> {
  CartCubit() : super([]);

  // 🛒 Add meal to cart
  void addToCart(Meal meal) {
    final copy = List<Meal>.from(state);
    final exists = copy.indexWhere((e) => e.id == meal.id);
    if (exists >= 0) return; // ✅ avoid duplicates
    copy.add(meal);
    emit(copy);
  }

  // ❌ Remove meal from cart
  void removeFromCart(String mealId) {
    emit(state.where((e) => e.id != mealId).toList());
  }

  // 🧹 Clear cart
  void clearCart() => emit([]);

  // ♻️ Hydrated persistence
  @override
  List<Meal>? fromJson(Map<String, dynamic> json) {
    final arr = (json['cart'] as List)
        .map((e) => Meal.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return List<Meal>.from(arr);
  }

  @override
  Map<String, dynamic>? toJson(List<Meal> state) => {
    'cart': state.map((e) => e.toMap()).toList(),
  };
}
