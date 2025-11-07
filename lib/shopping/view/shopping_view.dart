import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_demo/models/models.dart';
import 'package:monitoring_demo/monitoring/monitoring.dart';
import 'package:monitoring_demo/shopping/cubit/shopping_cubit.dart';
import 'package:monitoring_demo/shopping/widgets/widgets.dart';

class ShoppingView extends StatelessWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context) {
    final analytics = AnalyticsFacade();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            unawaited(analytics.trackBackToStoreEvent());
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Mi Carrito',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ShoppingCubit, ShoppingState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text('Tu carrito está vacío'),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: 24,
            ),
            child: Column(
              spacing: 24,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = state.cartItems[index];
                      return CartItemWidget(
                        product: product,
                        onIncrement: () {
                          unawaited(
                            analytics.trackChangeItemQuantityEvent(
                              action: ItemQuantityAction.increment,
                              itemId: product.id,
                              newQuantity: product.quantity + 1,
                            ),
                          );
                          context.read<ShoppingCubit>().incrementQuantity(
                            product.id,
                          );
                        },
                        onDecrement: () {
                          unawaited(
                            analytics.trackChangeItemQuantityEvent(
                              action: ItemQuantityAction.decrement,
                              itemId: product.id,
                              newQuantity: product.quantity - 1,
                            ),
                          );
                          context.read<ShoppingCubit>().decrementQuantity(
                            product.id,
                          );
                        },
                        onRemove: () {
                          unawaited(
                            analytics.trackRemoveFromCartEvent(
                              itemId: product.id,
                            ),
                          );
                          context.read<ShoppingCubit>().removeItem(product.id);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      unawaited(
                        analytics.trackScreenView(
                          screenName: 'shopping_checkout',
                        ),
                      );
                      _showOrderSummaryOverlay(context, state, analytics);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Completar compra',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showOrderSummaryOverlay(
    BuildContext baseContext,
    ShoppingState state,
    AnalyticsFacade analytics,
  ) {
    unawaited(
      showModalBottomSheet<void>(
        context: baseContext,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(baseContext).padding.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 24,
            children: [
              const Text(
                'Resumen de compra',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              OrderSummaryWidget(
                subtotal: state.subtotal,
                shipping: state.shipping,
                discount: state.discount,
                total: state.total,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    unawaited(
                      analytics.trackPurchaseEvent(
                        value: state.total,
                      ),
                    );
                    baseContext.read<ShoppingCubit>().completePurchase();
                    Navigator.of(baseContext).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Realizar pago',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
