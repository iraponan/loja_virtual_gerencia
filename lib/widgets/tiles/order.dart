import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});

  final DocumentSnapshot order;

  @override
  Widget build(BuildContext context) {
    final states = [
      '',
      'Em Preparação',
      'Em Transporte',
      'Aguardando Entrega',
      'Entregue'
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            '#${order.id.substring(order.id.length - 7, order.id.length)} - ${states[order.get('status')]}',
            style: TextStyle(
              color: order.get('status') != 4 ? Colors.grey[850] : Colors.green,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 0,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const OrderHeader(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.get('products').map<Widget>((p) {
                      return ListTile(
                        title: Text('${p['product']['title']} | ${p['size']}'),
                        subtitle: Text('${p['category']} | ${p['pid']}'),
                        trailing: Text(
                          p['quantity'].toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Excluir'),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[850],
                        ),
                        child: const Text('Regredir'),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                        ),
                        child: const Text('Avançar'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
