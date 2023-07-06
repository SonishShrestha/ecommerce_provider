class AllData {
  List<Products> products;
  int total;
  int skip;
  int limit;
  AllData(this.products, this.total, this.skip, this.limit);

  factory AllData.fromJson(Map<String, dynamic> getdata) {
    return AllData(
        (getdata['products'] as List<dynamic>)
            .map((e) => Products.getData(e))
            .toList(),
        getdata['total'],
        getdata['skip'],
        getdata['limit']);
  }
}

class Products {
  int id;
  String title;
  String description;
  int price;
  num discountPercentage;
  num rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;
  Products(
      this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images);

  factory Products.getData(Map<String, dynamic> data) {
    return Products(
        data['id'],
        data['title'],
        data['description'],
        data['price'],
        data['discountPercentage'],
        data['rating'],
        data['stock'],
        data['brand'],
        data['category'],
        data['thumbnail'],
        (data['images'] as List<dynamic>).map((e) => e.toString()).toList());
  }
}
