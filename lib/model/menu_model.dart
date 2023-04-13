class MenuModel {
  String? name;
  String? image;

  MenuModel({this.name, this.image});

  MenuModel.fromJson(Map<String, dynamic> fMap) {
    name = fMap["name"];
    image = fMap["image"];
  }

  toJson() {
    return {
      "name": name,
      "image": image,
    };
  }
}
