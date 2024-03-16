import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_gerencia/blocs/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage(
      {super.key, required this.categoryId, required this.product});

  final String categoryId;
  final DocumentSnapshot? product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductBloc _productBloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(
      categoryId: widget.categoryId,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    const fieldStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Criar Produto'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
            stream: _productBloc.outData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      initialValue: snapshot.data?['title'],
                      style: fieldStyle,
                      decoration: _buildDecoration('Título'),
                      onSaved: (t) {},
                      validator: (t) {},
                    ),
                    TextFormField(
                      initialValue: snapshot.data?['description'],
                      style: fieldStyle,
                      decoration: _buildDecoration('Descrição'),
                      maxLines: 6,
                      onSaved: (t) {},
                      validator: (t) {},
                    ),
                    TextFormField(
                      initialValue: UtilBrasilFields.obterReal(snapshot.data?['price'] ?? 0.0),
                      style: fieldStyle,
                      decoration: _buildDecoration('Preço'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onSaved: (t) {},
                      validator: (t) {},
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
