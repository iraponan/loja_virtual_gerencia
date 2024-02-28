import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/login.dart';
import 'package:loja_virtual_gerencia/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
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
                        onPressed: snapshot.hasData ? _loginBloc.submit : null,
                        child: const Text('Entrar'),
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
