import 'package:musicapp/data/models/meal/meal.dart';
import 'package:musicapp/data/repository/meal/meal_repository.dart';

class SearchMealsUseCase {
  final MealRepository repository;

  SearchMealsUseCase(this.repository);

  Future<List<Meal>> call(String query) async {
    if (query.isEmpty) return [];
    return await repository.searchMeals(query);
  }
}
