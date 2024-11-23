
class Product {
  String? id;
  String? name;
  String? description;
  num? price;
  String? category;
  num? version;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.version,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['_id'],
    name: json['name'],
    description: json['description'],
    price: json['price'],
    category: json['category'],
    version: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'price': price,
    'category': category,
    '__v': version,
  };
}
