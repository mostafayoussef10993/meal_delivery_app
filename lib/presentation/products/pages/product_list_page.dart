// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/widgets/appbar/search_bar.dart';
import 'package:musicapp/common/widgets/appbar/bottom_bar.dart';
import 'package:musicapp/common/widgets/discount_box.dart';
import 'package:musicapp/core/config/assets/app_images.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';
import 'package:musicapp/presentation/products/bloc/product_bloc.dart';
import 'package:musicapp/presentation/products/bloc/product_event.dart';
import 'package:musicapp/presentation/products/bloc/product_state.dart';
import 'package:musicapp/presentation/product_detail/pages/product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final int pageLimit = 10;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
  }

  Future<void> _onRefresh() async {
    context.read<ProductBloc>().add(LoadProducts(refresh: true));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Products"), centerTitle: true),
      body: Column(
        children: [
          // 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchBarWidget(
              onChanged: (query) {
                if (query.isEmpty) {
                  context.read<ProductBloc>().add(LoadProducts());
                } else {
                  context.read<ProductBloc>().add(SearchProducts(query));
                }
              },
            ),
          ),

          // 🎁 Discount Banner
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DiscountBox(),
          ),

          // 📦 Products Content
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading || state is ProductSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  );
                } else if (state is ProductEmpty) {
                  return Center(
                    child: Text(
                      "No products found",
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                } else if (state is ProductSearchResult) {
                  return _buildGrid(context, state.results);
                } else if (state is ProductLoaded) {
                  final products = state.products;
                  final totalPages = (state.totalItems / pageLimit).ceil();

                  return Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: _buildGrid(context, products),
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
                                    context.read<ProductBloc>().add(
                                      LoadProducts(
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

  /// 🛍️ Grid builder for products
  Widget _buildGrid(BuildContext context, List products) {
    final theme = Theme.of(context);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, i) {
        final p = products[i];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(productId: p.id),
              ),
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
                // 🖼 Product image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),

                  child: Image.network(
                    p.thumbnail.isNotEmpty ? p.thumbnail : AppImages.noImg,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${p.price.toStringAsFixed(2)}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            p.rating.toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
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
