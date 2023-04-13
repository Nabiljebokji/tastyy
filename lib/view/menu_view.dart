import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastyy/controller/viewModel/cart_viewmodel.dart';
import 'package:tastyy/controller/viewModel/home_viewmodel.dart';
import 'package:tastyy/view/addfood_view.dart';
import 'package:tastyy/view/cart_view.dart';
import 'package:tastyy/view/food_view.dart';

class MenuView extends GetView {
  MenuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Home'),
        actions: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(() => AddFoodView());
                },
                child: Text("Add Food"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black26),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => CartView());
                },
                icon: const Icon(Icons.add_shopping_cart_outlined),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: GetBuilder<CartViewModel>(
                  init: CartViewModel(),
                  builder: (controller) {
                    return Text("${controller.cart.length}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: const CardShepe(),
    );
  }
}

class CardShepe extends GetView {
  const CardShepe({super.key});

  // HomeViewModel homeController = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            physics: const ScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemCount: controller.menu.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // controller.addFoodListFromFireStore(index);
                  Get.to(() => FoodView(),
                      arguments: {"name": "${controller.menu[index].name}"});
                },
                child: Card(
                  elevation: 2.2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: Get.width - 25,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Image.network(
                              "${controller.menu[index].image}",
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(
                        "${controller.menu[index].name}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
