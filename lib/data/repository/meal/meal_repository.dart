import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:musicapp/data/models/meal/meal.dart';

class MealRepository {
  int? lastTotal;

  // ===============================
  // FETCH MEALS (with pagination)
  // ===============================
  Future<List<Meal>> fetchMeals({int limit = 10, int page = 1}) async {
    final jsonStr = await rootBundle.loadString(
      'assets/meal_data/sandwiches.json',
    );
    final List<dynamic> data = json.decode(jsonStr);

    // convert to list of Meal
    final meals = data
        .map((e) => Meal.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    lastTotal = meals.length;

    // pagination
    final start = (page - 1) * limit;
    final end = (start + limit > meals.length) ? meals.length : start + limit;

    return meals.sublist(start, end);
  }

  // ===============================
  // FETCH MEAL BY ID
  // ===============================
  Future<Meal?> fetchMealById(String id) async {
    final jsonStr = await rootBundle.loadString(
      'assets/meal_data/sandwiches.json',
    );
    final List<dynamic> data = json.decode(jsonStr);

    final meals = data
        .map((e) => Meal.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    try {
      return meals.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  // ===============================
  // SEARCH MEALS
  // ===============================
  Future<List<Meal>> searchMeals(String query) async {
    final jsonStr = await rootBundle.loadString(
      'assets/meal_data/sandwiches.json',
    );
    final List<dynamic> data = json.decode(jsonStr);

    final meals = data
        .map((e) => Meal.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return meals
        .where(
          (m) =>
              m.name.toLowerCase().contains(query.toLowerCase()) ||
              m.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
