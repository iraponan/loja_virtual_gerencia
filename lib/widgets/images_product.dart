import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImagesProduct extends FormField<List> {
  ImagesProduct({
    super.key,
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
                              state.didChange(state.value?..remove(i));
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
                              child: const Icon(Icons.camera_enhance),
                            ),
                            onTap: () {},
                          ),
                        ),
                    ),
                  ),
                  state.hasError
                      ? Text(
                          '${state.errorText}',
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        )
                      : const SizedBox.shrink(),
                ],
              );
            });
}
