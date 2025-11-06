part of 'shopping_cubit.dart';

class ShoppingState extends Equatable {
  const ShoppingState({
    this.cartItems = const [],
    this.subtotal = 0.0,
    this.shipping = 5.0,
    this.discount = 10.0,
  });

  final List<Product> cartItems;
  final double subtotal;
  final double shipping;
  final double discount;

  double get total => subtotal + shipping - discount;

  ShoppingState copyWith({
    List<Product>? cartItems,
    double? subtotal,
    double? shipping,
    double? discount,
  }) {
    return ShoppingState(
      cartItems: cartItems ?? this.cartItems,
      subtotal: subtotal ?? this.subtotal,
      shipping: shipping ?? this.shipping,
      discount: discount ?? this.discount,
    );
  }

  @override
  List<Object> get props => [cartItems, subtotal, shipping, discount];
}
