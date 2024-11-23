class AddProduct {
  String? name;
  String? description;
  int? price;
  String? category;
  String? sId;
  int? iV;

  AddProduct(
      {this.name,
        this.description,
        this.price,
        this.category,
        this.sId,
        this.iV});

  AddProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['category'] = this.category;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}