import 'package:equatable/equatable.dart';

abstract class MealEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMeals extends MealEvent {
  final int page;
  final int limit;
  final bool refresh;

  LoadMeals({this.page = 1, this.limit = 10, this.refresh = false});

  @override
  List<Object?> get props => [page, limit, refresh];
}

class LoadMealById extends MealEvent {
  final String id; // String because your JSON has string IDs
  LoadMealById(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchMeals extends MealEvent {
  final String query;
  SearchMeals(this.query);

  @override
  List<Object?> get props => [query];
}
