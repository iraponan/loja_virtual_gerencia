import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loja_virtual_gerencia/blocs/orders.dart';
import 'package:loja_virtual_gerencia/config/sort_criteria.dart';
import 'package:loja_virtual_gerencia/widgets/others/edit_category_dialog.dart';

class BuildFloating extends StatelessWidget {
  const BuildFloating({super.key, required this.page, required this.orderBloc});

  final int page;
  final OrdersBloc orderBloc;

  @override
  Widget build(BuildContext context) {
    Color colorDefault = Colors.pinkAccent;

    switch (page) {
      case 1:
        return SpeedDial(
          children: [
            SpeedDialChild(
                child: Icon(
                  Icons.arrow_downward,
                  color: colorDefault,
                ),
                backgroundColor: Colors.white,
                label: 'Concluídos Abaixo.',
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: colorDefault,
                ),
                onTap: () {
                  orderBloc.setOrderCriteria(SortCriteria.readLast);
                }),
            SpeedDialChild(
                child: Icon(
                  Icons.arrow_upward,
                  color: colorDefault,
                ),
                backgroundColor: Colors.white,
                label: 'Concluídos Acima.',
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: colorDefault,
                ),
                onTap: () {
                  orderBloc.setOrderCriteria(SortCriteria.readFirst);
                }),
          ],
          backgroundColor: colorDefault,
          foregroundColor: Colors.white,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          child: const Icon(Icons.sort),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const EditCategoryDialog(),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
