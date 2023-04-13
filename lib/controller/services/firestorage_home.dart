import 'package:firebase_storage/firebase_storage.dart';

class firebaseStorage {
  final storage = FirebaseStorage.instance;

  uploadImageToStorage(var imageName, var file) async {
    var storageRef = await storage.ref("images/$imageName");
    await storageRef.putFile(file);
    var Url = await storageRef.getDownloadURL();
    return Url;
  }

  getImagesAndFileNames() async {
    ListResult storageRef = await storage.ref("images").listAll();
  }
}
