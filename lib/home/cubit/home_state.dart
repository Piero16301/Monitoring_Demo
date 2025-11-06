part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.products = const [],
    this.filteredProducts = const [],
    this.selectedCategory = 'Todos',
    this.searchQuery = '',
    this.cartItemCount = 0,
  });

  final HomeStatus status;
  final List<Product> products;
  final List<Product> filteredProducts;
  final String selectedCategory;
  final String searchQuery;
  final int cartItemCount;

  HomeState copyWith({
    HomeStatus? status,
    List<Product>? products,
    List<Product>? filteredProducts,
    String? selectedCategory,
    String? searchQuery,
    int? cartItemCount,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      cartItemCount: cartItemCount ?? this.cartItemCount,
    );
  }

  @override
  List<Object> get props => [
    status,
    products,
    filteredProducts,
    selectedCategory,
    searchQuery,
    cartItemCount,
  ];
}
