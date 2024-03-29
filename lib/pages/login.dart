import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/login.dart';
import 'package:loja_virtual_gerencia/config/login_state.dart';
import 'package:loja_virtual_gerencia/pages/home.dart';
import 'package:loja_virtual_gerencia/widgets/others/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen(
      (state) {
        switch (state) {
          case LoginState.success:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case LoginState.fail:
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Erro'),
                content: Text('Você não possui os privilégios necessários!'),
              ),
            );
            break;
          case LoginState.loading:
          case LoginState.idle:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
          initialData: LoginState.loading,
          stream: _loginBloc.outState,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoginState.fail:
              case LoginState.success:
              case LoginState.idle:
                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.store_mall_directory,
                            size: 160,
                          ),
                          InputField(
                            icon: Icons.person_outline,
                            hint: 'Usuário',
                            obscure: false,
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          InputField(
                            icon: Icons.lock_outline,
                            hint: 'Senha',
                            obscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          StreamBuilder<bool>(
                              stream: _loginBloc.outSubmitValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: snapshot.hasData
                                        ? _loginBloc.submit
                                        : null,
                                    child: const Text('Entrar'),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                );
              case null:
                return Container();
            }
          }),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
