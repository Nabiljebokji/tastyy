import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastyy/controller/services/firestorage_home.dart';
import 'package:tastyy/controller/services/firestore_home.dart';
import 'package:tastyy/model/food_model.dart';
import 'package:tastyy/view/menu_view.dart';
import 'package:path/path.dart' as Path;

class AddFoodViewModel extends GetxController {
  List<FoodModel> newFood = [];

  String? selectedValue;
  String? imageName;
  String? imageURL;
  String? foodName;
  var pickedImage;
  int? foodPrice;
  File? file;
  static String? productId;
  ImagePicker imagePicker = ImagePicker();
  static bool imagepickedd = false;

  pickedCamera() async {
    pickedImage = await imagePicker.getImage(source: ImageSource.camera);
  }

  pickedGalary() async {
    pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
  }

  uploadImage() async {
    if (pickedImage != null) {
      imagepickedd = true;
      file = File(pickedImage!.path);

      imageName = Path.basename(pickedImage!.path);
      var random = Random().nextInt(10000000);
      imageName = "$random$imageName";
      print(imageName);
      print("===============");
      imageURL = await firebaseStorage().uploadImageToStorage(imageName, file);
      CollectionReference foodRef = await FirestoreHome().foodCollection;
      List<QueryDocumentSnapshot> foodcollection =
          await FirestoreHome().getFoodFromFirestore();

      foodRef.add({
        "name": foodName,
        "image": imageURL,
        "price": foodPrice,
        "id": productId,
      });
      update();
    } else {
      return Get.defaultDialog(
        title: "Error",
        middleText: "Please enter an image!",
        textCancel: "Back",
        onCancel: () {
          Get.back();
        },
      );
    }
  }

  saveData(formState) async {
    var formdata = formState.currentState;

    if (formdata!.validate()) {
      formdata.save();
      getSelectedId(selectedValue);
      print(selectedValue);
      uploadImage();
      Get.defaultDialog(
        title: "Successfully",
        textCancel: "Back",
        onCancel: () {
          Get.back();
        },
      );
    } else {
      Get.defaultDialog(
        title: "SomeThing went wrong,please try again !!",
        textCancel: "Back",
        onCancel: () {
          Get.back();
        },
      );
    }
  }

  void getSelectedId(selectedValue) async {
    List<QueryDocumentSnapshot> menuCollection =
        await FirestoreHome().getMenuFromFirestore();

    menuCollection.forEach((element) {
      if (element["name"] == selectedValue) {
        productId = element.id;
        print(productId);
      }
    });
    update();
  }

  selectedValuee(String? value) {
    selectedValue = value;

    update();
  }
}
