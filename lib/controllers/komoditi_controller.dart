import 'package:get/get.dart';

class KomoditiController extends GetxController {
  String path1, path2, path3, path4, path5;
  final allKomoditiImages = <String>[].obs;

  KomoditiController(
      this.path1, this.path2, this.path3, this.path4, this.path5);

  // @override
  // void onReady() {
  //   getAllKomoditi();
  //   super.onReady();
  // }

  // Future<void> getAllKomoditi() async {
  //   List<String> imgName = [path1, path2, path3, path4, path5];
  //   try {
  //     for (var img in imgName) {
  //       final imgUrl = await Get.find<FirebaseStorageService>().getImage(img);
  //       allKomoditiImages.add(imgUrl!);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
