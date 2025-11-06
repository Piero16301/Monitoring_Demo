import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_demo/models/product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    unawaited(_loadProducts());
  }

  Future<void> _loadProducts() async {
    emit(state.copyWith(status: HomeStatus.loading));

    await Future<void>.delayed(const Duration(seconds: 1));

    final products = [
      const Product(
        id: '1',
        name: 'Camiseta Clásica',
        price: 19.99,
        imageUrl: 'https://picsum.photos/500/500?random=1',
        category: 'Ropa',
      ),
      const Product(
        id: '2',
        name: 'Vaqueros Slim Fit',
        price: 49.99,
        imageUrl: 'https://picsum.photos/500/500?random=2',
        category: 'Ropa',
      ),
      const Product(
        id: '3',
        name: 'Zapatillas Urbanas',
        price: 74.99,
        imageUrl: 'https://picsum.photos/500/500?random=3',
        category: 'Calzado',
      ),
      const Product(
        id: '4',
        name: 'Sudadera con Capucha',
        price: 39.99,
        imageUrl: 'https://picsum.photos/500/500?random=4',
        category: 'Ropa',
      ),
      const Product(
        id: '5',
        name: 'Chaqueta de Cuero',
        price: 129.99,
        imageUrl: 'https://picsum.photos/500/500?random=5',
        category: 'Ropa',
        isPopular: true,
      ),
      const Product(
        id: '6',
        name: 'Pantalones Cortos',
        price: 24.99,
        imageUrl: 'https://picsum.photos/500/500?random=6',
        category: 'Ropa',
        isNew: true,
      ),
      const Product(
        id: '7',
        name: 'Vestido Elegante',
        price: 89.99,
        imageUrl: 'https://picsum.photos/500/500?random=7',
        category: 'Ropa',
        isPopular: true,
      ),
      const Product(
        id: '8',
        name: 'Botas de Invierno',
        price: 99.99,
        imageUrl: 'https://picsum.photos/500/500?random=8',
        category: 'Calzado',
      ),
      const Product(
        id: '9',
        name: 'Camisa Formal',
        price: 34.99,
        imageUrl: 'https://picsum.photos/500/500?random=9',
        category: 'Ropa',
      ),
      const Product(
        id: '10',
        name: 'Gorra Deportiva',
        price: 14.99,
        imageUrl: 'https://picsum.photos/500/500?random=10',
        category: 'Accesorios',
        isNew: true,
      ),
      const Product(
        id: '11',
        name: 'Bufanda de Lana',
        price: 24.99,
        imageUrl: 'https://picsum.photos/500/500?random=11',
        category: 'Accesorios',
      ),
      const Product(
        id: '12',
        name: 'Abrigo Largo',
        price: 149.99,
        imageUrl: 'https://picsum.photos/500/500?random=12',
        category: 'Ropa',
        isPopular: true,
      ),
      const Product(
        id: '13',
        name: 'Sandalias de Verano',
        price: 29.99,
        imageUrl: 'https://picsum.photos/500/500?random=13',
        category: 'Calzado',
        isOffer: true,
      ),
      const Product(
        id: '14',
        name: 'Cinturón de Cuero',
        price: 19.99,
        imageUrl: 'https://picsum.photos/500/500?random=14',
        category: 'Accesorios',
      ),
      const Product(
        id: '15',
        name: 'Falda Midi',
        price: 39.99,
        imageUrl: 'https://picsum.photos/500/500?random=15',
        category: 'Ropa',
        isNew: true,
      ),
      const Product(
        id: '16',
        name: 'Mochila Urbana',
        price: 44.99,
        imageUrl: 'https://picsum.photos/500/500?random=16',
        category: 'Accesorios',
      ),
      const Product(
        id: '17',
        name: 'Polo Deportivo',
        price: 27.99,
        imageUrl: 'https://picsum.photos/500/500?random=17',
        category: 'Ropa',
        isOffer: true,
      ),
      const Product(
        id: '18',
        name: 'Zapatillas Running',
        price: 84.99,
        imageUrl: 'https://picsum.photos/500/500?random=18',
        category: 'Calzado',
        isPopular: true,
      ),
      const Product(
        id: '19',
        name: 'Blazer Ejecutivo',
        price: 119.99,
        imageUrl: 'https://picsum.photos/500/500?random=19',
        category: 'Ropa',
      ),
      const Product(
        id: '20',
        name: 'Gafas de Sol',
        price: 54.99,
        imageUrl: 'https://picsum.photos/500/500?random=20',
        category: 'Accesorios',
        isNew: true,
      ),
    ];

    emit(
      state.copyWith(
        status: HomeStatus.success,
        products: products,
        filteredProducts: products,
      ),
    );
  }

  void selectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
    _filterProducts();
  }

  void searchProducts(String query) {
    emit(state.copyWith(searchQuery: query));
    _filterProducts();
  }

  void _filterProducts() {
    var filtered = state.products;

    // Filtrar por categoría
    if (state.selectedCategory != 'Todos') {
      if (state.selectedCategory == 'Nuevo') {
        filtered = filtered.where((p) => p.isNew).toList();
      } else if (state.selectedCategory == 'Ofertas') {
        filtered = filtered.where((p) => p.isOffer).toList();
      } else if (state.selectedCategory == 'Popular') {
        filtered = filtered.where((p) => p.isPopular).toList();
      } else {
        filtered = filtered
            .where((p) => p.category == state.selectedCategory)
            .toList();
      }
    }

    // Filtrar por búsqueda
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (p) =>
                p.name.toLowerCase().contains(state.searchQuery.toLowerCase()),
          )
          .toList();
    }

    emit(state.copyWith(filteredProducts: filtered));
  }

  void addToCart(Product product) {
    emit(state.copyWith(cartItemCount: state.cartItemCount + 1));
  }
}
