import 'package:flutter/material.dart';

class ImageRemoveSheet extends StatelessWidget {
  const ImageRemoveSheet({super.key, required this.onImageSelected});

  final Function(bool) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                onImageSelected(true);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete),
                  Text(' Apagar'),
                ],
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () {
                onImageSelected(false);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel),
                  Text(' Cancelar'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
