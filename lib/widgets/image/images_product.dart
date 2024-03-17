import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/others/object_remove_sheet.dart';
import 'package:loja_virtual_gerencia/widgets/image/image_source_sheet.dart';

class ImagesProduct extends FormField<List> {
  ImagesProduct({
    super.key,
    required BuildContext context,
    required FormFieldSetter<List> onSaved,
    required FormFieldValidator<List> validator,
    required List initialValue,
    bool autoValidateMode = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autoValidateMode
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 124,
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 8,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.value!.map<Widget>((i) {
                        return Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            right: 8,
                          ),
                          child: GestureDetector(
                            child: i is String
                                ? Image.network(
                                    i,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                  ),
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ObjectRemoveSheet(
                                  onImageSelected: (option) {
                                    if (option) {
                                      state.didChange(state.value?..remove(i));
                                      Navigator.of(context).pop();
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      }).toList()
                        ..add(
                          GestureDetector(
                            child: Container(
                              height: 100,
                              width: 100,
                              color: Colors.white.withAlpha(50),
                              child: const Icon(Icons.add),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ImageSourceSheet(
                                  onImageSelected: (image) {
                                    state.didChange(state.value?..add(image));
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
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
