import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:monitoring_demo/models/models.dart';
import 'package:monitoring_demo/monitoring/monitoring.dart';

class FirebaseAnalyticsClient implements AnalyticsClient {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> trackLoginEvent() async {
    await _analytics.logEvent(name: 'login');
  }

  @override
  Future<void> trackLoginFailedEvent({required String reason}) async {
    await _analytics.logEvent(
      name: 'login_failed',
      parameters: {'reason': reason},
    );
  }

  @override
  Future<void> trackChipCategoryEvent({required String category}) async {
    await _analytics.logEvent(
      name: 'select_category',
      parameters: {'category': category},
    );
  }

  @override
  Future<void> trackAddToCartEvent({
    required String itemId,
    required double price,
  }) async {
    await _analytics.logEvent(
      name: 'add_to_cart',
      parameters: {'item_id': itemId, 'price': price.toStringAsFixed(2)},
    );
  }

  @override
  Future<void> trackBeginCheckoutEvent() async {
    await _analytics.logEvent(name: 'begin_checkout');
  }

  @override
  Future<void> trackRemoveFromCartEvent({required String itemId}) async {
    await _analytics.logEvent(
      name: 'remove_from_cart',
      parameters: {'item_id': itemId},
    );
  }

  @override
  Future<void> trackChangeItemQuantityEvent({
    required ItemQuantityAction action,
    required String itemId,
    required int newQuantity,
  }) async {
    await _analytics.logEvent(
      name: 'change_item_quantity',
      parameters: {
        'item_id': itemId,
        'new_quantity': newQuantity,
        'action': action.name,
      },
    );
  }

  @override
  Future<void> trackBackToStoreEvent() async {
    await _analytics.logEvent(name: 'back_to_store');
  }

  @override
  Future<void> trackPurchaseEvent({required double value}) async {
    await _analytics.logEvent(
      name: 'purchase',
      parameters: {'total_price': value.toStringAsFixed(2)},
    );
  }

  @override
  Future<void> trackScreenView({required String screenName}) async {
    await _analytics.logEvent(
      name: 'screen_view',
      parameters: {'screen_name': screenName},
    );
  }
}
