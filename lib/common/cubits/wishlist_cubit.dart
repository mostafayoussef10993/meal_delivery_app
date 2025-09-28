// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:musicapp/data/models/product/product.dart';

class WishlistCubit extends HydratedCubit<List<Product>> {
  WishlistCubit() : super([]);

  void addToWishlist(Product p) {
    final copy = List<Product>.from(state);
    if (copy.any((e) => e.id == p.id)) return; // لو موجود مايتكررش
    copy.add(p);
    emit(copy);
  }

  void removeFromWishlist(int productId) {
    emit(state.where((e) => e.id != productId).toList());
  }

  void toggleWishlist(Product p) {
    final copy = List<Product>.from(state);
    final idx = copy.indexWhere((e) => e.id == p.id);
    if (idx >= 0)
      copy.removeAt(idx);
    else
      copy.add(p);
    emit(copy);
  }

  @override
  List<Product>? fromJson(Map<String, dynamic> json) {
    final arr = (json['wishlist'] as List)
        .map((e) => Product.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return List<Product>.from(arr);
  }

  @override
  Map<String, dynamic>? toJson(List<Product> state) => {
    'wishlist': state.map((e) => e.toMap()).toList(),
  };
}
