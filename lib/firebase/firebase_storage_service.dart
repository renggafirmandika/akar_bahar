import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// Reference get firebaseStorage => FirebaseStorage.instance.ref();

class FirebaseStorageService {
//   Future<String?> getImage(String? imgName) async {
//     if (imgName == null) {
//       return null;
//     }
//     try {
//       var urlRef =
//           firebaseStorage.child("Assets").child('${imgName.toLowerCase()}.jpg');
//       var imgUrl = await urlRef.getDownloadURL();
//       return imgUrl;
//     } catch (e) {
//       return null;
//     }
//   }

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('Assets').listAll();

    return results;
  }
}
