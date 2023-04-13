import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastyy/controller/viewModel/cart_viewmodel.dart';

class CartView extends StatelessWidget {
  CartView({super.key});

  CartViewModel cartController = Get.put(CartViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Cart'),
      ),
      body: GetBuilder<CartViewModel>(
        builder: (controller) {
          return controller.cartList.isEmpty
              ? Center(child: Text("The Cart is Empty"))
              : CardShepe();
        },
      ),
    );
  }
}

class CardShepe extends StatelessWidget {
  const CardShepe({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (cartController) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          physics: const ScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemCount: cartController.cartList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        height: 160,
                        width: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              "${cartController.cartList[index].image}",
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Name :",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Text("${cartController.cartList[index].name}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade500,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      cartController.incQuantity();
                                    },
                                    icon: const Icon(Icons.exposure_plus_1,
                                        size: 20),
                                  ),
                                ),
                              ),
                              GetBuilder<CartViewModel>(
                                builder: (controller) {
                                  return Text("${cartController.quantity}");
                                },
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade500,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      cartController.decQuantity();
                                    },
                                    icon: const Icon(
                                        Icons.exposure_neg_1_rounded,
                                        size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                              "Price : ${cartController.cartList[index].price}")
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            cartController.DeleteCart(
                                "${cartController.cartList[index].name}");
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.orange.shade500),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
