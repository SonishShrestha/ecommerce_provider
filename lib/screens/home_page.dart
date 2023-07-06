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
    final datas = AllData.fromJson(getAllDataResponse.data);
    final allData = datas.products;
    return allData;
  }

  getDataByCategory() async {
    Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/products/categories');
    categoryList = response.data;
  }

  Future<AllData> getDataByCategoryName(String name) async {
    Dio dio = Dio();
    final response =
        await dio.get('https://dummyjson.com/products/category/$name');
    final categoryByName = AllData.fromJson(response.data);

    return categoryByName;
  }

  @override
  void initState() {
    // TODO: implement initState

    getAllData();
    getDataByCategory();

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
            children: categoryList.map((catList) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      catList,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<AllData>(
                      future: getDataByCategoryName(catList),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: snapshot.data!.products!.map((e) {
                              return Card(
                                margin: EdgeInsets.all(20),
                                elevation: 10,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    children: [
                                      Text(e.title.toString()),
                                      Text(e.discountPercentage.toString()),
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
                                  ),
                                ),
                              );
                            }).toList()),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ));
  }
}
