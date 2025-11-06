import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    super.key,
  });

  final double subtotal;
  final double shipping;
  final double discount;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen del Pedido',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            'Subtotal',
            '\$${subtotal.toStringAsFixed(2)}',
            isRegular: true,
          ),
          const SizedBox(height: 6),
          _buildSummaryRow(
            'Envío',
            '\$${shipping.toStringAsFixed(2)}',
            isRegular: true,
          ),
          const SizedBox(height: 6),
          _buildSummaryRow(
            'Descuento',
            '-\$${discount.toStringAsFixed(2)}',
            isDiscount: true,
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          const SizedBox(height: 6),
          _buildSummaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isDiscount = false,
    bool isRegular = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isRegular
                ? Colors.grey[600]
                : isDiscount
                ? Colors.blue[400]
                : Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 24 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isDiscount ? Colors.blue[600] : Colors.black,
          ),
        ),
      ],
    );
  }
}
