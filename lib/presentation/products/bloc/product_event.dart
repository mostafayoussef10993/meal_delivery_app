import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  final int page;
  final int limit;
  final bool refresh;

  LoadProducts({this.page = 1, this.limit = 10, this.refresh = false});

  @override
  List<Object?> get props => [page, limit, refresh];
}

class LoadProductById extends ProductEvent {
  final int id;
  LoadProductById(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}
