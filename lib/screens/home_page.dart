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
  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePages'),
      ),
      drawer: Drawer(
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
      body: FutureBuilder<List<Products>?>(
        future: ApiResponse().getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
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
                }).toList(),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
