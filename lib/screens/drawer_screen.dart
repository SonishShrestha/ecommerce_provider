import 'package:e_commerce_provider/model/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                                  context
                                      .read<CartProduct>()
                                      .quantiyDecrement();
                                },
                                icon: Icon(Icons.remove)),
                            Text(context
                                .watch<CartProduct>()
                                .quantity
                                .toString()),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<CartProduct>()
                                      .quantityIncrement();
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
    );
  }
}
