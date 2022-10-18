import 'package:flutter/material.dart';
import 'package:intern_assignment/models/shoes.dart';

class Cart with ChangeNotifier {
  final List<Shoes> _shoes = [];

  get shoes => _shoes;

  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;

  double get totalPrice {
    return _totalPrice;
  }

  int get itemCount {
    return _shoes.length;
  }

  addCart(Shoes shoe) {
    _shoes.add(shoe);
    notifyListeners();
  }

  removeCart(int id) {
    _shoes.removeWhere(
      (element) => element.id == id,
    );
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    notifyListeners();
  }

  updateItems(Shoes items) {
    items.update();

    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice -= productPrice;

    notifyListeners();
  }

  double getTotalPrice() {
    return _totalPrice;
  }

  void addCounter(int id) {
    _counter++;

    notifyListeners();
  }

  void removeCounter() {
    _counter++;
    notifyListeners();
  }
}
