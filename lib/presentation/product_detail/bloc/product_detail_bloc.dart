import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/data/repository/product/product_repository.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository repo;

  ProductDetailBloc({required this.repo}) : super(ProductDetailInitial()) {
    on<LoadProductDetail>((event, emit) async {
      emit(ProductDetailLoading());
      try {
        final product = await repo.fetchProductById(event.productId);
        emit(ProductDetailLoaded(product!));
      } catch (e) {
        emit(ProductDetailError(e.toString()));
      }
    });
  }
}
