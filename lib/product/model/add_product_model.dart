class ProductModel {
  String id;
  String? name;
  num? price;
  String? image;
  String? description;
  num? discountAmount;
  String? categoryId;
  num? stock;
  num? created;
  num? modified;

  ProductModel({
    required this.id,
    this.name,
    this.price,
    this.image,
    this.description,
    this.discountAmount,
    this.categoryId,
    this.stock,
    this.created,
    this.modified,
  });


  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
      discountAmount: json['discountAmount'],
      categoryId: json['categoryId'],
      stock: json['stock'],
      created: json['created'],
      modified: json['modified'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'discountAmount': discountAmount,
      'categoryId': categoryId,
      'stock': stock,
      'created': created,
      'modified': modified,
    };
  }
}