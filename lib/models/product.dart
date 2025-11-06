import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.category = 'Todos',
    this.isNew = false,
    this.isOffer = false,
    this.isPopular = false,
    this.size,
    this.color,
    this.quantity = 1,
  });

  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final bool isNew;
  final bool isOffer;
  final bool isPopular;
  final String? size;
  final String? color;
  final int quantity;

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? category,
    bool? isNew,
    bool? isOffer,
    bool? isPopular,
    String? size,
    String? color,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isNew: isNew ?? this.isNew,
      isOffer: isOffer ?? this.isOffer,
      isPopular: isPopular ?? this.isPopular,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    imageUrl,
    category,
    isNew,
    isOffer,
    isPopular,
    size,
    color,
    quantity,
  ];
}
