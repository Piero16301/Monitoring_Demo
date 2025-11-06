import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_demo/models/models.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(const ShoppingState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Datos iniciales del carrito según la imagen
    final initialItems = [
      const Product(
        id: '21',
        name: 'Classic Leather Sneakers',
        price: 79.99,
        imageUrl: 'https://picsum.photos/500/500?random=21',
        size: '42',
        color: 'Blanco',
      ),
      const Product(
        id: '22',
        name: 'Modern Fit T-Shirt',
        price: 49,
        imageUrl: 'https://picsum.photos/500/500?random=22',
        size: 'M',
        color: 'Negro',
        quantity: 2,
      ),
      const Product(
        id: '23',
        name: 'Running Shoes',
        price: 120,
        imageUrl: 'https://picsum.photos/500/500?random=23',
        size: '43',
        color: 'Azul',
      ),
      const Product(
        id: '24',
        name: 'Casual Denim Jacket',
        price: 89.99,
        imageUrl: 'https://picsum.photos/500/500?random=24',
        size: 'L',
        color: 'Azul',
      ),
      const Product(
        id: '25',
        name: 'Sports Cap',
        price: 24.99,
        imageUrl: 'https://picsum.photos/500/500?random=25',
        size: 'Única',
        color: 'Rojo',
        quantity: 3,
      ),
    ];

    _updateCartWithItems(initialItems);
  }

  void _updateCartWithItems(List<Product> items) {
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    emit(
      state.copyWith(
        cartItems: items,
        subtotal: subtotal,
      ),
    );
  }

  void incrementQuantity(String productId) {
    final updatedItems = state.cartItems.map((item) {
      if (item.id == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    _updateCartWithItems(updatedItems);
  }

  void decrementQuantity(String productId) {
    final updatedItems = state.cartItems.map((item) {
      if (item.id == productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();

    _updateCartWithItems(updatedItems);
  }

  void removeItem(String productId) {
    final updatedItems = state.cartItems
        .where((item) => item.id != productId)
        .toList();

    _updateCartWithItems(updatedItems);
  }

  void completePurchase() {
    // Lógica para completar la compra
    // Aquí puedes agregar navegación, API calls, etc.
  }
}
