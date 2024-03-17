import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/sizes/add_size_dialog.dart';
import 'package:loja_virtual_gerencia/widgets/others/object_remove_sheet.dart';

class ProductSizes extends FormField<List> {
  ProductSizes({
    super.key,
    required BuildContext context,
    required List initialValue,
    required FormFieldSetter<List> onSaved,
    required FormFieldValidator<List> validator,
    bool autoValidateMode = false,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autoValidateMode
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
                          onTap: () async {
                            String size = await showDialog(
                              context: context,
                              builder: (context) => const AddSizeDialog(),
                            );
                            if (size.isNotEmpty) {
                              state.didChange(state.value?..add(size));
                            }
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
                            child: const Text(
                              '+',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    ),
                  ),
                  state.hasError
                      ? Text(
                    '${state.errorText}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  )
                      : const SizedBox.shrink(),
                ],
              );
            });
}
