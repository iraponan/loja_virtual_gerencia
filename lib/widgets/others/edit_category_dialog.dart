import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/category.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({super.key, this.category});

  final DocumentSnapshot? category;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  @override
  Widget build(BuildContext context) {
    CategoryBloc? categoryBloc = CategoryBloc(category: widget.category);
    TextEditingController controller = TextEditingController(
        text: widget.category != null
            ? widget.category?.get('title')
            : '');

    return Dialog(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: GestureDetector(
                child: StreamBuilder(
                    stream: categoryBloc.outImage,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: snapshot.data is File
                              ? Image.file(
                                  snapshot.data,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  snapshot.data,
                                  fit: BoxFit.cover,
                                ),
                        );
                      } else {
                        return const Icon(Icons.image);
                      }
                    }),
              ),
              title: TextField(
                controller: controller,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<bool>(
                    stream: categoryBloc.outDelete,
                    initialData: false,
                    builder: (context, snapshot) {
                      return TextButton(
                        onPressed: snapshot.data ?? false ? () {} : null,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                        ),
                        child: const Text('Excluir'),
                      );
                    }),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                  ),
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
