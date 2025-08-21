import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final deliveryStatus = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDeliveryStatus();
  }

  Future<void> getDeliveryStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      deliveryStatus.value = prefs.getBool('delivery_status') ?? false;
    } catch (e) {
      deliveryStatus.value = false;
    }
  }

  Future<void> setDeliveryStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('delivery_status', deliveryStatus.value);

      String message = deliveryStatus.value
          ? 'Delivery status enabled'
          : 'Delivery status disabled';
      AppWidgets().getSnackBar(message: message);
    } catch (e) {
      AppWidgets().getSnackBar(message: 'Error updating delivery status');
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      AppWidgets().getSnackBar(message: 'Logged out successfully');

      // Navigate to login screen
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      AppWidgets().getSnackBar(message: 'Error during logout');
    }
  }
}
