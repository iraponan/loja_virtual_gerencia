import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/tiles/user_tile.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Pesquisar...',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return const UserTile();
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
