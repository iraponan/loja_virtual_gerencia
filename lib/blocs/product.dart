import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  ProductBloc({required this.categoryId, this.product}) {
    if (product != null) {
      unsavedData = product!.data() as Map<String, dynamic>;
      unsavedData['images'] = List.of(product!.get('images'));
      unsavedData['sizes'] = List.of(product!.get('sizes'));
      
      _createdController.add(true);
    } else {
      unsavedData = {
        'title': null,
        'description': null,
        'price': null,
        'images': [],
        'sizes': []
      };
      _createdController.add(false);
    }

    _dataController.add(unsavedData);
  }

  late String categoryId;
  late DocumentSnapshot? product;
  late Map<String, dynamic> unsavedData;

  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();

  SettableMetadata metadata = SettableMetadata(
    contentType: "image/jpeg",
  );

  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  void saveTitle(String? text) {
    unsavedData['title'] = text;
  }

  void saveDescription(String? text) {
    unsavedData['description'] = text;
  }

  void savePrice(String? text) {
    unsavedData['price'] = double.tryParse(
        text!.replaceAll('R\$ ', '').replaceAll('.', '').replaceAll(',', '.'));
  }

  void saveImages(List? images) {
    unsavedData['images'] = images;
  }

  void saveSizes(List? sizes) {
    unsavedData['sizes'] = sizes;
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);
    try {
      if (product != null) {
        await _uploadImages(product!.id);
        await product!.reference.update(unsavedData);
      } else {
        DocumentReference documentReference = await FirebaseFirestore.instance
            .collection('products')
            .doc(categoryId)
            .collection('itens')
            .add(Map.from(unsavedData)..remove('images'));
        await _uploadImages(documentReference.id);
        await documentReference.update(unsavedData);
      }
      _createdController.add(true);
      _loadingController.add(false);
      return true;
    } catch (e) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String id) async {
    for (int i = 0; i < unsavedData['images'].length; i++) {
      if (unsavedData['images'][i] is String) continue;

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(id)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData['images'][i], metadata);

      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      unsavedData['images'][i] = downloadUrl;
    }
  }

  Future<void> deleteProduct () async {
    List<dynamic> images = List.of(product?.get('images'));
    for (int i = 0; i < images.length; i++) {
      await FirebaseStorage.instance.refFromURL(images[i]).delete().catchError((e) => print(e));
    }
    product?.reference.delete();
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
    super.dispose();
  }
}
