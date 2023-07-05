import 'package:dio/dio.dart';
import 'package:e_commerce_provider/model/all_products.dart';
import 'package:flutter/material.dart';

class ApiResponse extends ChangeNotifier {
  final List<Products> _cartData = [];
  List<Products> get cartData => _cartData;
}
