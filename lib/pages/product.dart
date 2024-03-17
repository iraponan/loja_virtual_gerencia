import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_gerencia/blocs/product.dart';
import 'package:loja_virtual_gerencia/validators/product.dart';
import 'package:loja_virtual_gerencia/widgets/image/images_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage(
      {super.key, required this.categoryId, required this.product});

  final String categoryId;
  final DocumentSnapshot? product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with ProductValidator {
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
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
              }
            },
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
                    const Text(
                      'Imagens',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    ImagesProduct(
                      context: context,
                      onSaved: _productBloc.saveImages,
                      validator: validateImages,
                      initialValue: snapshot.data?['images'],
                    ),
                    TextFormField(
                      initialValue: snapshot.data?['title'],
                      style: fieldStyle,
                      decoration: _buildDecoration('Título'),
                      textCapitalization: TextCapitalization.sentences,
                      onSaved: _productBloc.saveTitle,
                      validator: validateTitle,
                    ),
                    TextFormField(
                      initialValue: snapshot.data?['description'],
                      style: fieldStyle,
                      decoration: _buildDecoration('Descrição'),
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 6,
                      onSaved: _productBloc.saveDescription,
                      validator: validateDescription,
                    ),
                    TextFormField(
                      initialValue: UtilBrasilFields.obterReal(
                          snapshot.data?['price'] ?? 0.0),
                      style: fieldStyle,
                      decoration: _buildDecoration('Preço'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onSaved: _productBloc.savePrice,
                      validator: validatePrice,
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
