import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_demo/home/cubit/home_cubit.dart';
import 'package:monitoring_demo/home/widgets/category_chip.dart';
import 'package:monitoring_demo/home/widgets/product_card.dart';
import 'package:monitoring_demo/home/widgets/search_bar_widget.dart';
import 'package:monitoring_demo/monitoring/monitoring.dart';
import 'package:monitoring_demo/shopping/shopping.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final analytics = AnalyticsFacade();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Productos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(color: Color(0xFF007AFF)),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Productos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 16,
                    top: 16,
                  ),
                  child: SearchBarWidget(
                    onChanged: (query) {
                      context.read<HomeCubit>().searchProducts(query);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final label = getCategoryLabel(index);
                      return CategoryChip(
                        label: label,
                        isSelected: state.selectedCategory == label,
                        onTap: () {
                          unawaited(
                            analytics.trackChipCategoryEvent(
                              category: label,
                            ),
                          );
                          context.read<HomeCubit>().selectCategory(
                            label,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(),
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = state.filteredProducts[index];
                      return ProductCard(
                        product: product,
                        onAddToCart: () {
                          unawaited(
                            analytics.trackAddToCartEvent(
                              itemId: product.id,
                              price: product.price,
                            ),
                          );
                          context.read<HomeCubit>().addToCart(product);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.name} añadido al carrito',
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: state.filteredProducts.length,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: state.cartItemCount > 0
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        unawaited(analytics.trackBeginCheckoutEvent());
                        unawaited(
                          Navigator.of(context).pushNamed(
                            ShoppingPage.routeName,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${state.cartItemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }

  int getCrossAxisCount() {
    if (Platform.isAndroid || Platform.isIOS) {
      return 2;
    } else {
      return 5;
    }
  }

  String getCategoryLabel(int index) {
    switch (index) {
      case 0:
        return 'Todos';
      case 1:
        return 'Nuevo';
      case 2:
        return 'Ofertas';
      case 3:
        return 'Popular';
      default:
        return 'Todos';
    }
  }
}
