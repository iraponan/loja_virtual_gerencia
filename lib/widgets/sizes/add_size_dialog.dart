import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/validators/product.dart';

class AddSizeDialog extends StatelessWidget with ProductValidator {
  const AddSizeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();

    return Dialog(
      alignment: Alignment.center,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          errorMaxLines: 2,
                        ),
                        controller: controller,
                        textCapitalization: TextCapitalization.none,
                        validator: validateSizeText,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          Navigator.of(context)
                              .pop(controller.text.toUpperCase());
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.pinkAccent,
                      ),
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
