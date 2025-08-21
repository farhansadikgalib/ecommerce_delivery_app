import 'package:get/get.dart';

import '../../../core/helper/auth_helper.dart';
import '../../../core/helper/shared_value_helper.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initializeApp();
  }

  initializeApp() async {
    await AuthHelper().loadItems();
    await Future.delayed(2500.milliseconds);
    await isLoggedIn.load().whenComplete(() async {
      if (isLoggedIn.$) {
        Get.offNamed(Routes.HOME);
      } else {
        AuthHelper().clearUserData();
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}
