import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastyy/controller/viewModel/cart_viewmodel.dart';
import 'package:tastyy/controller/viewModel/food_viewmodel.dart';
import 'package:tastyy/view/cart_view.dart';

class FoodView extends StatelessWidget {
  const FoodView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Food'),
        actions: [
          Row(
            children: [
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
      body: FoodCardShepe(),
    );
  }
}

class FoodCardShepe extends StatelessWidget {
  FoodCardShepe({super.key});

  CartViewModel cartController = Get.put(CartViewModel(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodViewModel>(
      init: FoodViewModel(),
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
            ),
            physics: const ScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemCount: controller.food.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Card(
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
                                "${controller.food[index].image}",
                                fit: BoxFit.cover),
                          ),
                        ),
                        Text(
                          "${controller.food[index].name}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              cartController
                                  .addToCart("${controller.food[index].name}");
                            },
                            icon: const Icon(Icons.add, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
