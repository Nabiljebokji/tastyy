import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tastyy/controller/services/firestore_home.dart';
import 'package:tastyy/model/menu_model.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  List<MenuModel> menu = [];

  List<MenuModel> get menuList => menu;

  @override
  void onInit() {
    super.onInit();
    getMenuListFromFireStore();
  }

  getMenuListFromFireStore() async {
    List<QueryDocumentSnapshot> menuListSnapshot =
        await FirestoreHome().getMenuFromFirestore();

    menuListSnapshot.forEach((data) {
      menu.add(MenuModel.fromJson(data.data() as Map<String, dynamic>));
    });
    update();
  }
}
