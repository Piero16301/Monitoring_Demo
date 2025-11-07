import 'package:monitoring_demo/models/models.dart';

abstract class AnalyticsClient {
  // Para LOGIN
  Future<void> trackLoginEvent();

  // Para STORE
  Future<void> trackChipCategoryEvent({required String category});
  Future<void> trackAddToCartEvent({
    required String itemId,
    required double price,
  });
  Future<void> trackBeginCheckoutEvent();

  // Para CART
  Future<void> trackRemoveFromCartEvent({required String itemId});
  Future<void> trackChangeItemQuantityEvent({
    required ItemQuantityAction action,
    required String itemId,
    required int newQuantity,
  });
  Future<void> trackBackToStoreEvent();
  Future<void> trackPurchaseEvent({required double value});
  Future<void> trackScreenView({required String screenName});
}
