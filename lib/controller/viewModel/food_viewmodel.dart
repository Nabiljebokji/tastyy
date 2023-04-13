import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tastyy/controller/services/firestore_home.dart';
import 'package:tastyy/model/food_model.dart';
import 'package:get/get.dart';

class FoodViewModel extends GetxController {
  List<FoodModel> food = [];

  String? selectedname;

  List<FoodModel> get foodList => food;

  @override
  void onInit() {
    super.onInit();
    selectedname = Get.arguments["name"];
    addFoodListFromFireStore();
  }

  addFoodListFromFireStore() async {
    List<QueryDocumentSnapshot> foodListSnapshot =
        await FirestoreHome().getFoodFromFirestore();

    List<QueryDocumentSnapshot> menuListSnapshot =
        await FirestoreHome().getMenuFromFirestore();

    menuListSnapshot.forEach((value) {
      if (value["name"] == selectedname) {
        var selectedmenu = value.id;

        foodListSnapshot.forEach((element) {
          if (element['id'] == selectedmenu) {
            food.add(
                FoodModel.fromJson(element.data() as Map<String, dynamic>));
          }
        });
      }
    });
    update();
  }
}
