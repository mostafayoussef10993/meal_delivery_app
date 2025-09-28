import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:musicapp/data/models/product/product.dart';

class CartCubit extends HydratedCubit<List<Product>> {
  CartCubit() : super([]);

  void addToCart(Product p) {
    final copy = List<Product>.from(state);
    final exists = copy.indexWhere((e) => e.id == p.id);
    if (exists >= 0) return;
    copy.add(p);
    emit(copy);
  }

  void removeFromCart(int productId) {
    // خلي الاسم consistent
    emit(state.where((e) => e.id != productId).toList());
  }

  void clearCart() => emit([]);

  @override
  List<Product>? fromJson(Map<String, dynamic> json) {
    final arr = (json['cart'] as List)
        .map((e) => Product.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return List<Product>.from(arr);
  }

  @override
  Map<String, dynamic>? toJson(List<Product> state) => {
    'cart': state.map((e) => e.toMap()).toList(),
  };
}
