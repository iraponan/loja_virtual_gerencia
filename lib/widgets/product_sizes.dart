import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/object_remove_sheet.dart';

class ProductSizes extends FormField<List> {
  ProductSizes({
    super.key,
    required BuildContext context,
    required List initialValue,
    required FormFieldSetter<List> onSaved,
    required FormFieldValidator<List> validator,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            builder: (state) {
              return SizedBox(
                height: 34,
                child: GridView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.5,
                  ),
                  children: state.value!.map((s) {
                    return GestureDetector(
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ObjectRemoveSheet(
                            onImageSelected: (option) {
                              if (option) {
                                state.didChange(state.value?..remove(s));
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 3,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          s,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList()
                    ..add(GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 3,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '+',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                ),
              );
            });
}
