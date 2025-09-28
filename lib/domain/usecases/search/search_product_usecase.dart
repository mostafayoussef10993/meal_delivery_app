import 'package:musicapp/data/models/product/product.dart';
import 'package:musicapp/data/repository/product/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<List<Product>> call(String query) async {
    if (query.isEmpty) return [];
    return await repository.searchProducts(query);
  }
}
