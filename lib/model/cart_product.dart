import 'package:dio/dio.dart';
import 'package:e_commerce_provider/model/all_products.dart';
import 'package:flutter/material.dart';

class CartProduct extends ChangeNotifier {
  final List<CartProduct> _cartData = [];
  List<CartProduct> get cartData => _cartData;
  List categoryList = [];

  int _quantity;
  int get quantity => _quantity;

  final Products? _cartProducts;
  Products? get cartProducts => _cartProducts;

  CartProduct({int quantity = 1, Products? cartProducts})
      : _quantity = quantity,
        _cartProducts = cartProducts;

  void quantityIncrement() {
    _quantity++;
    notifyListeners();
  }

  void quantiyDecrement() {
    _quantity--;
    notifyListeners();
  }

  getDataByCategory() async {
    Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/products/categories');
    categoryList = response.data;
    notifyListeners();
  }
}
