import 'package:e_commerce_provider/model/all_products.dart';
import 'package:flutter/material.dart';

class CartProduct extends ChangeNotifier {
  int quantity;
  Products cartProducts;
  CartProduct(this.quantity, this.cartProducts);
}

class CartProductList extends ChangeNotifier {
  final List<CartProduct> _cartData = [];
  List<CartProduct> get cartData => _cartData;
}
