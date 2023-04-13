import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastyy/controller/viewModel/addfood_viewmodel.dart';

class AddFoodView extends GetView {
  AddFoodView({super.key});
  AddFoodViewModel addController = Get.put(AddFoodViewModel());

  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Add Food"),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Get.bottomSheet(BottomSheets());
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 200,
                        width: 200,
                        child: addController.newFood.isEmpty
                            ? const Icon(
                                Icons.fastfood,
                                size: 100,
                              )
                            : Image.network("${addController.newFood}",
                                fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                GetBuilder<AddFoodViewModel>(
                  init: AddFoodViewModel(),
                  builder: (addController) {
                    return DropdownButton(
                      items: const [
                        DropdownMenuItem(
                            value: "Grills", child: Text("Grills")),
                        DropdownMenuItem(
                            value: "Burgers", child: Text("Burgers")),
                        DropdownMenuItem(
                            value: "Sandwich", child: Text("Sandwich")),
                        DropdownMenuItem(value: "Pizza", child: Text("Pizza")),
                        DropdownMenuItem(
                            value: "Cold Drinks", child: Text("Cold Drinks")),
                        DropdownMenuItem(
                            value: "Hot Drinks", child: Text("Hot Drinks")),
                      ],
                      hint: const Text("Choose Category"),
                      onChanged: (value) {
                        addController.selectedValuee(value as String?);
                      },
                      value: addController.selectedValue,
                    );
                  },
                ),
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          controller: nameController,
                          onSaved: (newValue) {
                            addController.foodName = newValue;
                          },
                          validator: (value) {
                            if (value!.length < 15) {
                              return null;
                            }
                            return "Name must be less than 15 characters";
                          },
                          decoration: InputDecoration(
                            label: Text("Product Name"),
                            prefixIcon:
                                Icon(Icons.card_giftcard, color: Colors.orange),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          onSaved: (newValue) {
                            addController.foodPrice =
                                int.parse(priceController.text);
                          },
                          validator: (value) {
                            if (value!.length < 10) {
                              return null;
                            }
                            return "Name must not be more than 10 characters";
                          },
                          decoration: InputDecoration(
                            label: Text("Product Price"),
                            prefixIcon: Icon(Icons.monetization_on_rounded,
                                color: Colors.orange),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange)),
                            onPressed: () {
                              Get.bottomSheet(BottomSheets());
                            },
                            icon: Icon(Icons.image),
                            label: Text("Add Image"),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange)),
                            icon: Icon(Icons.save),
                            label: Text("Save Changes"),
                            onPressed: () async {
                              await addController.saveData(formState);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class BottomSheets extends GetView {
  BottomSheets({super.key});
  AddFoodViewModel addController = Get.put(AddFoodViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Please Choose Image:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                icon: Icon(Icons.camera),
                label: Text("From Camera"),
                onPressed: () {
                  addController.pickedCamera();
                  Get.back();
                },
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                icon: Icon(Icons.photo_outlined),
                label: Text("From Gallery"),
                onPressed: () {
                  addController.pickedGalary();
                  Get.back();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
