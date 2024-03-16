import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_gerencia/config/sort_criteria.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();
  final List<DocumentSnapshot> _orders = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late SortCriteria _criteria;

  Stream<List> get outOrders => _ordersController.stream;

  OrdersBloc() {
    _criteria = SortCriteria.readLast;
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection('orders').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        String oid = change.doc.id;
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.doc);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.id == oid);
            _orders.add(change.doc);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.id == oid);
            break;
        }
      }
      _sort();
    });
  }

  void setOrderCriteria(SortCriteria criteria) {
    _criteria = criteria;
    _sort();
  }

  void _sort() {
    switch (_criteria) {
      case SortCriteria.readFirst:
        _orders.sort((a, b) {
          int statusA = a.get('status');
          int statusB = b.get('status');

          if (statusA < statusB) {
            return 1;
          } else if (statusA > statusB) {
            return -1;
          } else {
            return 0;
          }
        });
        break;
      case SortCriteria.readLast:
        _orders.sort((a, b) {
          int statusA = a.get('status');
          int statusB = b.get('status');

          if (statusA < statusB) {
            return -1;
          } else if (statusA > statusB) {
            return 1;
          } else {
            return 0;
          }
        });
        break;
    }
    _ordersController.add(_orders);
  }

  @override
  void dispose() {
    _ordersController.close();
    super.dispose();
  }
}
