import 'package:dio/dio.dart';
import 'package:e_commerce_provider/model/all_products.dart';
import 'package:flutter/material.dart';

class ApiResponse extends ChangeNotifier {
  final List<Products> _allData = [];
  List<Products> get allData => _allData;

  List<Products> _categoryList = [];
  List<Products> get categoryList => _categoryList;

  final List<Products> _cartData = [];
  List<Products> get cartData => _cartData;

  Future<List<Products>?> getAllData() async {
    Dio dio = Dio();
    final getAllDataResponse = await dio.get('https://dummyjson.com/products/');
    final datas = AllData.fromJson(getAllDataResponse.data);
    final allData = datas.products;
    return allData;
  }

  void getDataByCategory() async {
    Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/products/categories');
    _categoryList = response.data;
    notifyListeners();
  }
}
