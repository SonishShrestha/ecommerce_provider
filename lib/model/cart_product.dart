import 'package:e_commerce_provider/model/all_products.dart';
import 'package:flutter/material.dart';

class CartProduct extends ChangeNotifier {
  final List<Products> _cartData = [];
  List<Products> get cartData => _cartData;

  int? _quantity;
  int? get quantity => _quantity;

  final Products? _cartProducts;
  Products? get cartProducts => _cartProducts;

  CartProduct({int? quantity, Products? cartProducts})
      : _quantity = quantity,
        _cartProducts = cartProducts;

  set quantity(value) {
    _quantity = value++;
    notifyListeners();
  }
}
