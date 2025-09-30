import 'package:equatable/equatable.dart';
import 'package:musicapp/data/models/meal/meal.dart';

abstract class MealState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;
  final int currentPage;
  final int totalItems;

  MealLoaded(this.meals, {this.currentPage = 1, this.totalItems = 0});

  @override
  List<Object?> get props => [meals, currentPage, totalItems];
}

class MealSearching extends MealState {}

class MealSearchResult extends MealState {
  final List<Meal> results;
  MealSearchResult(this.results);

  @override
  List<Object?> get props => [results];
}

class MealError extends MealState {
  final String message;
  MealError(this.message);

  @override
  List<Object?> get props => [message];
}

class MealEmpty extends MealState {}
