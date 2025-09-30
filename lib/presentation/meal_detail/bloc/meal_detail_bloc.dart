import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/data/repository/meal/meal_repository.dart';
import 'package:musicapp/presentation/meal_detail/bloc/meal_detail_event.dart';
import 'package:musicapp/presentation/meal_detail/bloc/meal_detail_state.dart';

class MealDetailBloc extends Bloc<MealDetailEvent, MealDetailState> {
  final MealRepository repo;

  MealDetailBloc({required this.repo}) : super(MealDetailInitial()) {
    on<LoadMealDetail>((event, emit) async {
      emit(MealDetailLoading());
      try {
        final meal = await repo.fetchMealById(event.mealId);
        if (meal != null) {
          emit(MealDetailLoaded(meal));
        } else {
          emit(const MealDetailError("Meal not found"));
        }
      } catch (e) {
        emit(MealDetailError(e.toString()));
      }
    });
  }
}
