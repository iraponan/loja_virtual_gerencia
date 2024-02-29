import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/orders.dart';
import 'package:loja_virtual_gerencia/widgets/tiles/order.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersBloc = BlocProvider.getBloc<OrdersBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: StreamBuilder<List>(
          stream: ordersBloc.outOrders,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum pedido encontrado!',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return OrderTile(
                    order: snapshot.data?[index],
                  );
                },
                itemCount: snapshot.data?.length ?? 0,
              );
            }
          }),
    );
  }
}
