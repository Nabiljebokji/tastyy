class CartModel {
  String? name;
  String? image;
  String? productId;
  int? quantity;
  int? price;

  CartModel({
    required this.name,
    required this.image,
    required this.price,
    required this.productId,
    this.quantity = 1,
  });

  CartModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    price = map['price'];
    productId = map['productId'];
    quantity = map['quantity'];
  }
}
