import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tastyy/controller/services/firestore_home.dart';
import 'package:tastyy/model/cart_model.dart';

class CartViewModel extends GetxController {
  List<CartModel> cart = [];
  late String productId;
  List<CartModel> get cartList => cart;
  static bool click = true;
  int quantity = 1;

  @override
  void onInit() {
    super.onInit();
    getcartListFromFireStore();
  }

  incQuantity() {
    quantity++;
    update();
  }

  decQuantity() {
    if (quantity > 1) {
      quantity--;
      update();
    }
  }

  getcartListFromFireStore() async {
    List<QueryDocumentSnapshot> cartListSnapshot =
        await FirestoreHome().getCartFromFirestore();
    update();
  }

  void addToCart(String? name) async {
    CollectionReference cartRef = await FirestoreHome().cartCollection;

    List<QueryDocumentSnapshot> foodCollection =
        await FirestoreHome().getFoodFromFirestore();

    List<QueryDocumentSnapshot> cartCollection =
        await FirestoreHome().getCartFromFirestore();

    foodCollection.forEach((element) {
      if (element["name"] == name) {
        productId = element.id;

        if (!cartCollection.contains(name) || cart.isEmpty) {
          cart.add(CartModel.fromJson(element.data() as Map<dynamic, dynamic>));
          cartRef.add({
            "name": element["name"],
            "image": element["image"],
            "price": element["price"],
            "productId": productId,
            "quantity": quantity,
          });
        }
      }
    });
    update();
  }

  void DeleteCart(String name) async {
    var thisId;
    var cartRef = FirestoreHome().cartCollection;

    List<QueryDocumentSnapshot> cartquery =
        await FirestoreHome().getCartFromFirestore();

    cartRef.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            cartquery.forEach((element) {
              if (element["name"] == name) {
                thisId = doc.id;
                cartRef.doc(thisId).delete().then((value) {
                  cart.removeWhere((element) => element.name == name);
                  update();
                }).catchError((e) {
                  print("==============================");
                  print("Error is : $e");
                  print("==============================");
                });
              }
            });
          })
        });
  }
}
