import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/data/repository/product/product_repository.dart';
import 'package:musicapp/domain/usecases/search/search_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  final SearchProductsUseCase searchProductsUseCase;

  ProductBloc({required this.repository, required this.searchProductsUseCase})
    : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductById>(_onLoadById);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());

      final list = await repository.fetchProducts(
        limit: event.limit,
        page: event.page,
      );
      final totalItems = repository.lastTotal ?? list.length;

      if (list.isEmpty) {
        emit(ProductEmpty());
      } else {
        emit(
          ProductLoaded(list, currentPage: event.page, totalItems: totalItems),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadById(
    LoadProductById event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());
      final product = await repository.fetchProductById(event.id);
      emit(ProductLoaded([?product]));
    } catch (err) {
      emit(ProductError(err.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductSearching());
      final results = await searchProductsUseCase(event.query);
      if (results.isEmpty) {
        emit(ProductEmpty());
      } else {
        emit(ProductSearchResult(results));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
