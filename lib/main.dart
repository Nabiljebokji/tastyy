import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastyy/firebase_options.dart';
import 'package:tastyy/view/addfood_view.dart';
import 'package:tastyy/view/cart_view.dart';
import 'package:tastyy/view/menu_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => MenuView()),
        GetPage(name: "/cartview", page: () => CartView()),
        GetPage(name: "/cartview", page: () => CartView()),
        GetPage(name: "/addfoodview", page: () => AddFoodView()),
      ],
    );
  }
}
