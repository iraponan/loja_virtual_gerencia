import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/pages/product.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});

  final DocumentSnapshot category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(category.get('icon')),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            category.get('title'),
            style: TextStyle(
              color: Colors.grey[850],
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            FutureBuilder<QuerySnapshot>(
              future: category.reference.collection('itens').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                } else {
                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doc.get('images')[0]),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(doc.get('title')),
                        trailing:
                            Text('R\$ ${doc.get('price').toStringAsFixed(2)}'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage(
                              categoryId: category.id,
                              product: doc,
                            ),
                          ));
                        },
                      );
                    }).toList()
                      ..add(ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.add),
                        ),
                        title: const Text('Adicionar'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    categoryId: category.id,
                                    product: null,
                                  )));
                        },
                      )),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
