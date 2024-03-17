import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  ProductBloc({required this.categoryId, this.product}) {
    if (product != null) {
      unsavedData = product!.data() as Map<String, dynamic>;
      unsavedData['images'] = List.of(product!.get('images'));
      unsavedData['sizes'] = List.of(product!.get('sizes'));
    } else {
      unsavedData = {
        'title': null,
        'description': null,
        'price': null,
        'images': [],
        'sizes': []
      };
    }

    _dataController.add(unsavedData);
  }

  late String categoryId;
  late DocumentSnapshot? product;
  late Map<String, dynamic> unsavedData;

  final _dataController = BehaviorSubject<Map>();

  Stream<Map> get outData => _dataController.stream;

  void saveTitle (String? text) {
    unsavedData['title'] = text;
  }

  void saveDescription (String? text) {
    unsavedData['description'] = text;
  }

  void savePrice (String? text) {
    unsavedData['price'] = double.parse(text!);
  }

  void saveImages (List? images) {
    unsavedData['images'] = images;
  }

  @override
  void dispose() {
    super.dispose();
    _dataController.close();
  }
}