import 'package:dio/dio.dart';
import 'package:e_commerce_provider/model/all_products.dart';

import 'package:e_commerce_provider/model/cart_product.dart';
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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('HomePages'),
        ),
        endDrawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                Consumer<CartProduct>(
                  builder: (context, value, child) {
                    return Column(
                        children: value.cartData.map((e) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(e.cartProducts!.images[0])),
                              title: Text(e.cartProducts!.title),
                              subtitle: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        e.quantiyDecrement();
                                      },
                                      icon: Icon(Icons.remove)),
                                  Text(e.quantity.toString()),
                                  IconButton(
                                      onPressed: () {
                                        e.quantityIncrement();
                                      },
                                      icon: Icon(Icons.add)),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }).toList());
                  },
                )
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
                                children: snapshot.data!.products.map((e) {
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
                                      Image.network(
                                        e.images[0],
                                        width: 150,
                                        height: 150,
                                      ),
                                      Text(e.title.toString()),
                                      Text(
                                          '${e.discountPercentage.toString()}\$'),
                                      ElevatedButton(
                                          onPressed: () {
                                            final cartDatas =
                                                Provider.of<CartProduct>(
                                                    context,
                                                    listen: false);
                                            final data = cartDatas.cartData
                                                .where((element) =>
                                                    element.cartProducts!.id ==
                                                    e.id);

                                            if (data.isEmpty) {
                                              cartDatas.cartData.add(
                                                  CartProduct(cartProducts: e));
                                            } else {
                                              data.first.quantityIncrement();
                                            }
                                          },
                                          child: Text('add to cart'))
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
