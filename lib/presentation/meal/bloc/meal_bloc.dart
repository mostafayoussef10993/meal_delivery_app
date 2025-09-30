import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/data/repository/meal/meal_repository.dart';
import 'package:musicapp/domain/usecases/search/search_meal_usecase.dart';
import 'package:musicapp/presentation/meal/bloc/meal_event.dart';
import 'package:musicapp/presentation/meal/bloc/meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository repository;
  final SearchMealsUseCase searchMealsUseCase;

  MealBloc({required this.repository, required this.searchMealsUseCase})
    : super(MealInitial()) {
    on<LoadMeals>(_onLoadMeals);
    on<LoadMealById>(_onLoadById);
    on<SearchMeals>(_onSearchMeals);
  }

  Future<void> _onLoadMeals(LoadMeals event, Emitter<MealState> emit) async {
    try {
      emit(MealLoading());

      final list = await repository.fetchMeals(
        limit: event.limit,
        page: event.page,
      );
      final totalItems = repository.lastTotal ?? list.length;

      if (list.isEmpty) {
        emit(MealEmpty());
      } else {
        emit(MealLoaded(list, currentPage: event.page, totalItems: totalItems));
      }
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> _onLoadById(LoadMealById event, Emitter<MealState> emit) async {
    try {
      emit(MealLoading());
      final meal = await repository.fetchMealById(event.id);
      if (meal != null) {
        emit(MealLoaded([meal]));
      } else {
        emit(MealEmpty());
      }
    } catch (err) {
      emit(MealError(err.toString()));
    }
  }

  Future<void> _onSearchMeals(
    SearchMeals event,
    Emitter<MealState> emit,
  ) async {
    try {
      emit(MealSearching());
      final results = await searchMealsUseCase(event.query);
      if (results.isEmpty) {
        emit(MealEmpty());
      } else {
        emit(MealSearchResult(results));
      }
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }
}
