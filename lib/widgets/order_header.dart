import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Iraponan'),
            Text('Rua de Teste'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Preço Produtos',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Preço Total',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
