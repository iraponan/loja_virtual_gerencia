import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/user_bloc.dart';
import 'package:loja_virtual_gerencia/widgets/tiles/user_tile.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.getBloc<UserBloc>();

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
          child: StreamBuilder<List>(
              stream: _userBloc.outUsers,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum usuário encontrado!',
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(
                        user: snapshot.data?[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: snapshot.data?.length ?? 0,
                  );
                }
              }),
        ),
      ],
    );
  }
}