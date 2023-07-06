import 'package:flutter/material.dart';

class AllData extends ChangeNotifier {
  List<Products>? _products;

  List<Products>? get products => _products;

  int? _total;
  int? get total => _total;

  int? _skip;
  int? get skip => _skip;

  int? _limit;
  int? get limit => _limit;

  AllData({List<Products>? products, int? total, int? skip, int? limit})
      : _products = products,
        _total = total,
        _skip = skip,
        _limit = limit;

  factory AllData.fromJson(Map<String, dynamic> data) {
    return AllData(
        products: (data['products'] as List<dynamic>).map((e) {
          return Products.getData(e);
        }).toList(),
        total: data['total'],
        skip: data['skip'],
        limit: data['limit']);
  }
}

class Products extends ChangeNotifier {
  int? _id;
  String? _title;
  String? _description;
  int? _price;
  num? _discountPercentage;
  num? _rating;
  int? _stock;
  String? _brand;
  String? _category;
  String? _thumbnail;
  List<String>? _images;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  int? get price => _price;
  num? get discountPercentage => _discountPercentage;
  num? get rating => _rating;
  int? get stock => _stock;
  String? get brand => _brand;
  String? get category => _category;
  String? get thumbnail => _thumbnail;
  List<String>? get images => _images;

  Products(
      {int? id,
      String? title,
      String? description,
      int? price,
      num? discountPercentage,
      num? rating,
      int? stock,
      String? brand,
      String? category,
      String? thumbnail,
      List<String>? images})
      : _id = id,
        _title = title,
        _description = description,
        _price = price,
        _discountPercentage = discountPercentage,
        _rating = rating,
        _stock = stock,
        _brand = brand,
        _category = category,
        _thumbnail = thumbnail,
        _images = images;

  factory Products.getData(Map<String, dynamic> proData) {
    return Products(
        id: proData['id'],
        title: proData['title'],
        description: proData['description'],
        price: proData['price'],
        discountPercentage: proData['discountPercentage'],
        rating: proData['rating'],
        stock: proData['stock'],
        brand: proData['brand'],
        category: proData['category'],
        thumbnail: proData['thumbnail'],
        images: (proData['images'] as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }
}
