import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/user_bloc.dart';
import 'package:loja_virtual_gerencia/widgets/tabs/users_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  late UserBloc _userBloc;

  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (page) {
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCirc,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Produtos',
          ),
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          blocs: [Bloc((i) => _userBloc)],
          dependencies: [],
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _page = page;
              });
            },
            children: [
              const UsersTab(),
              Container(color: Colors.yellow),
              Container(color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
