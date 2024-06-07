import 'package:get/get.dart';

class PromoController extends GetxController {
  static PromoController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }
}
