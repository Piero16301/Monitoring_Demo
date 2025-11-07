import 'package:monitoring_demo/models/models.dart';
import 'package:monitoring_demo/monitoring/monitoring.dart';

class AnalyticsFacade implements AnalyticsClient {
  factory AnalyticsFacade() {
    return _instance;
  }

  AnalyticsFacade._internal();

  static final AnalyticsFacade _instance = AnalyticsFacade._internal();

  final AnalyticsClient _client = FirebaseAnalyticsClient();

  @override
  Future<void> trackLoginEvent() {
    return _client.trackLoginEvent();
  }

  @override
  Future<void> trackLoginFailedEvent({required String reason}) {
    return _client.trackLoginFailedEvent(reason: reason);
  }

  @override
  Future<void> trackChipCategoryEvent({required String category}) {
    return _client.trackChipCategoryEvent(category: category);
  }

  @override
  Future<void> trackAddToCartEvent({
    required String itemId,
    required double price,
  }) {
    return _client.trackAddToCartEvent(itemId: itemId, price: price);
  }

  @override
  Future<void> trackBeginCheckoutEvent() {
    return _client.trackBeginCheckoutEvent();
  }

  @override
  Future<void> trackRemoveFromCartEvent({required String itemId}) {
    return _client.trackRemoveFromCartEvent(itemId: itemId);
  }

  @override
  Future<void> trackChangeItemQuantityEvent({
    required ItemQuantityAction action,
    required String itemId,
    required int newQuantity,
  }) {
    return _client.trackChangeItemQuantityEvent(
      action: action,
      itemId: itemId,
      newQuantity: newQuantity,
    );
  }

  @override
  Future<void> trackBackToStoreEvent() {
    return _client.trackBackToStoreEvent();
  }

  @override
  Future<void> trackPurchaseEvent({required double value}) {
    return _client.trackPurchaseEvent(value: value);
  }

  @override
  Future<void> trackScreenView({required String screenName}) {
    return _client.trackScreenView(screenName: screenName);
  }
}
