import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/widgets/button/checkout_button.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';
import 'package:musicapp/data/models/meal/meal.dart';
import 'package:musicapp/data/repository/meal/meal_repository.dart';
import 'package:musicapp/presentation/meal_detail/bloc/meal_detail_bloc.dart';
import 'package:musicapp/presentation/meal_detail/bloc/meal_detail_event.dart';
import 'package:musicapp/presentation/meal_detail/bloc/meal_detail_state.dart';
import 'package:musicapp/common/widgets/button/add_to_cart_button.dart';

class MealDetailPage extends StatelessWidget {
  final String mealId; // ✅ String because JSON IDs are strings

  const MealDetailPage({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) =>
          MealDetailBloc(repo: MealRepository())..add(LoadMealDetail(mealId)),
      child: BlocBuilder<MealDetailBloc, MealDetailState>(
        builder: (context, state) {
          if (state is MealDetailLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is MealDetailError) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Error: ${state.message}",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ),
            );
          } else if (state is MealDetailLoaded) {
            final Meal meal = state.meal;

            return Scaffold(
              appBar: AppBar(
                title: const Text("Meal Details"),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📸 Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        meal.image,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/no_image.png", // replace with AppImages.noImg if available
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 🏷️ Name
                    Text(
                      meal.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 💵 Price
                    Text(
                      "\$${meal.price.toStringAsFixed(2)}",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ⭐ Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          meal.rating.toString(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // 🌍 Country
                    Text(
                      meal.country,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    const Divider(height: 32, thickness: 1),

                    // 📝 Description
                    Text(
                      "Description",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      meal.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 80), // leave space for button
                  ],
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(child: AddToCartButton(meal: meal)),
                      const SizedBox(width: 12),
                      Expanded(child: CheckoutButton()),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
