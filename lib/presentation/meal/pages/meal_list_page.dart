// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/widgets/appbar/search_bar.dart';
import 'package:musicapp/common/widgets/appbar/bottom_bar.dart';
import 'package:musicapp/common/widgets/discount_box.dart';
import 'package:musicapp/core/config/assets/app_images.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';
import 'package:musicapp/presentation/meal/bloc/meal_bloc.dart';
import 'package:musicapp/presentation/meal/bloc/meal_event.dart';
import 'package:musicapp/presentation/meal/bloc/meal_state.dart';
import 'package:musicapp/presentation/meal_detail/pages/meal_detail_page.dart';
import 'package:musicapp/data/models/meal/meal.dart';

class MealListPage extends StatefulWidget {
  const MealListPage({super.key});

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final int pageLimit = 10;

  @override
  void initState() {
    super.initState();
    context.read<MealBloc>().add(LoadMeals());
  }

  Future<void> _onRefresh() async {
    context.read<MealBloc>().add(LoadMeals(refresh: true));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Meals"), centerTitle: true),
      body: Column(
        children: [
          // 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchBarWidget(
              onChanged: (query) {
                if (query.isEmpty) {
                  context.read<MealBloc>().add(LoadMeals());
                } else {
                  context.read<MealBloc>().add(SearchMeals(query));
                }
              },
            ),
          ),

          // 🎁 Discount Banner
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DiscountBox(),
          ),

          // 🍔 Meals Content
          Expanded(
            child: BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealLoading || state is MealSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  );
                } else if (state is MealEmpty) {
                  return Center(
                    child: Text(
                      "No meals found",
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                } else if (state is MealSearchResult) {
                  return _buildGrid(context, state.results);
                } else if (state is MealLoaded) {
                  final meals = state.meals;
                  final totalPages = (state.totalItems / pageLimit).ceil();

                  return Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: _buildGrid(context, meals),
                        ),
                      ),
                      // 📑 Pagination
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(totalPages, (index) {
                              final pageNumber = index + 1;
                              final isActive = state.currentPage == pageNumber;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isActive
                                        ? AppColors.primary
                                        : AppColors.grey,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(40, 36),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<MealBloc>().add(
                                      LoadMeals(
                                        page: pageNumber,
                                        limit: pageLimit,
                                      ),
                                    );
                                  },
                                  child: Text("$pageNumber"),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  /// 🛍️ Grid builder for meals
  Widget _buildGrid(BuildContext context, List<Meal> meals) {
    final theme = Theme.of(context);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, i) {
        final m = meals[i];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => MealDetailPage(mealId: m.id)),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: AppColors.grey.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Meal image with error fallback
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    m.image,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImages.noImg,
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${m.price.toStringAsFixed(2)}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        m.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
