import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_demo/home/cubit/home_cubit.dart';
import 'package:monitoring_demo/home/widgets/category_chip.dart';
import 'package:monitoring_demo/home/widgets/product_card.dart';
import 'package:monitoring_demo/home/widgets/search_bar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    children: [
                      CategoryChip(
                        label: 'Todos',
                        isSelected: state.selectedCategory == 'Todos',
                        onTap: () {
                          context.read<HomeCubit>().selectCategory(
                            'Todos',
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      CategoryChip(
                        label: 'Nuevo',
                        isSelected: state.selectedCategory == 'Nuevo',
                        onTap: () {
                          context.read<HomeCubit>().selectCategory(
                            'Nuevo',
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      CategoryChip(
                        label: 'Ofertas',
                        isSelected: state.selectedCategory == 'Ofertas',
                        onTap: () {
                          context.read<HomeCubit>().selectCategory(
                            'Ofertas',
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      CategoryChip(
                        label: 'Popular',
                        isSelected: state.selectedCategory == 'Popular',
                        onTap: () {
                          context.read<HomeCubit>().selectCategory(
                            'Popular',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
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
                      onPressed: () => Navigator.of(context).pushNamed(
                        '/shopping',
                      ),
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
}
