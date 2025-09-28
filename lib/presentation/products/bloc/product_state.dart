import 'package:equatable/equatable.dart';
import 'package:musicapp/data/models/product/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final int currentPage;
  final int totalItems;

  ProductLoaded(this.products, {this.currentPage = 1, this.totalItems = 0});

  @override
  List<Object?> get props => [products, currentPage, totalItems];
}

class ProductSearching extends ProductState {}

class ProductSearchResult extends ProductState {
  final List<Product> results;
  ProductSearchResult(this.results);

  @override
  List<Object?> get props => [results];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProductEmpty extends ProductState {}
