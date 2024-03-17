import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/user.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key, required this.order});

  final DocumentSnapshot order;

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.getBloc<UserBloc>();
    final user = userBloc.getUser(order.get('clientId'));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user?['name']}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${user?['address']}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Produtos: R\$ ${order.get('productsPrice').toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Total: R\$ ${order.get('totalPrice').toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
