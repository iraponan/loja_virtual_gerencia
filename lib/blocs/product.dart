import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductBloc extends BlocBase {
  ProductBloc({required this.categoryId, required this.product});

  late String categoryId;
  late DocumentSnapshot product;

  @override
  void dispose() {
    super.dispose();
  }
}