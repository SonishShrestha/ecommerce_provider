import 'dart:math';

import 'package:dio/dio.dart';
import 'package:e_commerce_provider/model/all_products.dart';
import 'package:e_commerce_provider/model/api_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Products> allData = [];
  List categoryList = [];
  // List<Products> categoryByName = [];

  Future<List<Products>?> getAllData() async {
    Dio dio = Dio();
    final getAllDataResponse = await dio.get('https://dummyjson.com/products/');
    final datas = ListProducts.getData(getAllDataResponse.data);
    final allData = datas.products;
    return allData;
  }

  Future<List<Products>?> getDataByCategory() async {
    Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/products/categories');
    final categoryList = response.data;
    return categoryList;
  }

  //  Future<Products> getDataByCategoryName(String name) async {
  //   Dio dio = Dio();
  //   final response =
  //       await dio.get('https://dummyjson.com/products/categories/$name');
  //   final categoryByName = ListProducts.getData(response.data);

  //   return categoryByName;
  // }

  @override
  void initState() {
    // TODO: implement initState

    getAllData();
    getDataByCategory();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    print(categoryList);
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePages'),
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                Consumer<ApiResponse>(builder: (context, value, child) {
                  return Column(
                      children: value.cartData.map((e) {
                    return Text(e.title.toString());
                  }).toList());
                })
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: categoryList.map((catList) {
                  return Text(catList);
                }).toList(),
              ),
              FutureBuilder<List<Products>?>(
                future: getDataByCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data!.map((e) {
                      return Column(
                        children: [
                          Text(e.title.toString()),
                          Consumer<ApiResponse>(
                            builder: (context, value, child) {
                              return ElevatedButton(
                                  onPressed: () {
                                    value.cartData.add(e);
                                  },
                                  child: Text('add to cart'));
                            },
                          )
                        ],
                      );
                    }).toList());
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
