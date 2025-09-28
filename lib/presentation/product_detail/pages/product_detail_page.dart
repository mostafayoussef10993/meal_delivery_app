// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/widgets/button/add_to_cart_button.dart';
import 'package:musicapp/common/widgets/button/add_to_wishlist_button.dart';
import 'package:musicapp/data/repository/product/product_repository.dart';
import 'package:musicapp/presentation/product_detail/bloc/product_detail_bloc.dart';
import 'package:musicapp/presentation/product_detail/bloc/product_detail_event.dart';
import 'package:musicapp/presentation/product_detail/bloc/product_detail_state.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) =>
          ProductDetailBloc(repo: ProductRepository())
            ..add(LoadProductDetail(productId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              );
            } else if (state is ProductDetailLoaded) {
              final product = state.product;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📸 Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.thumbnail,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 🏷️ Title
                    Text(
                      product.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 💵 Price
                    Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 🏷 Brand & Category
                    Text(
                      "${product.brand} • ${product.category}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 🔖 Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: product.tags
                          .map(
                            (tag) => Chip(
                              label: Text(
                                tag,
                                style: theme.textTheme.bodySmall,
                              ),
                              backgroundColor: Color.fromARGB(255, 243, 2, 2),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),

                    // ⭐ Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
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
                      product.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    const Divider(height: 32, thickness: 1),

                    // 🗨 Reviews
                    Text(
                      "Reviews",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (product.reviews.isEmpty)
                      Text(
                        "No reviews yet",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: product.reviews.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final review = product.reviews[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.reviewerName,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimaryLight,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    review.comment,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondaryLight,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${review.rating} ⭐ • ${review.date.toLocal().toString().split(' ')[0]}",
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 24),

                    // 🛒 Action Buttons
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AddToCartButton(product: product),
                          AddToWishlistButton(product: product),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
