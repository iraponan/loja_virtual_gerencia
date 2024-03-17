import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_gerencia/blocs/product.dart';
import 'package:loja_virtual_gerencia/validators/product.dart';
import 'package:loja_virtual_gerencia/widgets/image/images_product.dart';
import 'package:loja_virtual_gerencia/widgets/sizes/product_sizes.dart';

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
        title: StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(snapshot.data! ? 'Editar Produto' : 'Criar Produto');
            }),
        actions: [
          StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return StreamBuilder<bool>(
                    stream: _productBloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                        onPressed: snapshot.data!
                            ? null
                            : () {
                                _productBloc.deleteProduct();
                                Navigator.of(context).pop();
                              },
                        icon: const Icon(Icons.remove),
                      );
                    });
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                  onPressed: snapshot.data! ? null : saveProduct,
                  icon: const Icon(Icons.save),
                );
              }),
        ],
      ),
      body: Stack(
        children: [
          Form(
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
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onSaved: _productBloc.savePrice,
                          validator: validatePrice,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Tamanhos',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        ProductSizes(
                          context: context,
                          initialValue: snapshot.data?['sizes'],
                          onSaved: _productBloc.saveSizes,
                          validator: validateSize,
                          autoValidateMode: true,
                        ),
                      ],
                    );
                  }
                }),
          ),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                FocusManager.instance.primaryFocus?.unfocus();
                return IgnorePointer(
                  ignoring: !snapshot.data!,
                  child: Container(
                    color: snapshot.data! ? Colors.black54 : Colors.transparent,
                  ),
                );
              }),
        ],
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

  Future<void> saveProduct() async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Salvando o produto...',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(minutes: 1),
        ),
      );
      bool success = await _productBloc.saveProduct();
      if (!context.mounted) {
        return;
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Produto Salvo!' : 'Erro ao salvar produto',
              style: const TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}
