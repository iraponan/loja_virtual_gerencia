import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key, required this.onImageSelected});

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () async {
                XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                imageSelected(image);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_enhance),
                  Text(' Câmera')
                ],
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                imageSelected(image);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_search),
                  Text(' Galeria')
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void imageSelected(XFile? image) async {
    if (image != null) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(
          ratioX: 1.0,
          ratioY: 1.0,
        ),
      );
      onImageSelected(File(croppedImage!.path));
    }
  }
}
