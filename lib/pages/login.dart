import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                const InputField(
                  icon: Icons.person_outline,
                  hint: 'Usuário',
                  obscure: false,
                ),
                const InputField(
                  icon: Icons.lock_outline,
                  hint: 'Senha',
                  obscure: true,
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Entrar'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
