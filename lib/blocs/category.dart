import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  CategoryBloc({this.category}) {
    if (category != null) {
      title = category!.get('title');
      _titleController.add(category!.get('title'));
      _imageController.add(category!.get('icon'));
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  final _titleController = BehaviorSubject<String>();
  final _imageController = BehaviorSubject();
  final _deleteController = BehaviorSubject<bool>();
  final DocumentSnapshot? category;

  File? image;
  String? title;

  SettableMetadata metadata = SettableMetadata(
    contentType: "image/jpeg",
  );

  Stream<String> get outTitle => _titleController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (title, sink) {
        if (title.isEmpty) {
          sink.addError('Insira um título!');
        } else {
          sink.add(title);
        }
      }));
  Stream get outImage => _imageController.stream;
  Stream<bool> get outDelete => _deleteController.stream;
  Stream<bool> get submitValid => CombineLatestStream.combine2(outTitle, outImage, (a, b) => true);

  void setImage(File file) {
    image = file;
    _imageController.add(image);
  }

  void setTitle(String text) {
    title = text;
    _titleController.add(title!);
  }

  Future<void> saveData() async {
    if (image == null && category != null && title == category!.get('title')) {
      return;
    }
    Map<String, dynamic> dataToSave = {};

    if (image != null && title != null) {
      UploadTask task = FirebaseStorage.instance.ref().child('icons').child(title!).putFile(image!, metadata);
      TaskSnapshot snap = await task;
      dataToSave['icon'] = await snap.ref.getDownloadURL();
    }

    if (category == null || category?.get('title') != title) {
      dataToSave['title'] = title;
    }

    if (category == null) {
      await FirebaseFirestore.instance.collection('products').doc(title?.toLowerCase()).set(dataToSave);
    } else {
      await category?.reference.update(dataToSave);
    }
  }

  void delete() async {
    String images = category!.get('icon');
    await FirebaseStorage.instance.refFromURL(images).delete().catchError((e) => print(e));
    category?.reference.delete();
  }

  @override
  void dispose() {
    _titleController.close();
    _imageController.close();
    _deleteController.close();
    super.dispose();
  }
}
