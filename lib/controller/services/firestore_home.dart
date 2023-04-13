import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHome {
  final CollectionReference menuCollection =
      FirebaseFirestore.instance.collection('menu');

  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('food');

  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Future<List<QueryDocumentSnapshot>> getMenuFromFirestore() async {
    var menu = await menuCollection.get();
    return menu.docs;
  }

  Future<List<QueryDocumentSnapshot>> getFoodFromFirestore() async {
    var food = await foodCollection.get();
    return food.docs;
  }

  Future<List<QueryDocumentSnapshot>> getCartFromFirestore() async {
    var cart = await foodCollection.get();
    return cart.docs;
  }
}
