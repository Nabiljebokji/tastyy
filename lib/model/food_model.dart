class FoodModel {
  String? foodId;
  String? name;
  String? image;
  int? price;

  FoodModel({this.foodId, this.name, this.image, this.price});

  FoodModel.fromJson(Map<String, dynamic> fMap) {
    foodId = fMap["id"];
    name = fMap["name"];
    image = fMap["image"];
    price = fMap["price"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": foodId,
      "name": name,
      "image": image,
      "price": price,
    };
  }
}
