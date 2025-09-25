import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/core/helper/print_log.dart';
import 'package:delivery_app/app/core/helper/shared_value_helper.dart';
import 'package:delivery_app/app/data/repository/home/home_repository.dart';
import 'package:delivery_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final deliveryStatus = false.obs;
  final dailyDelivery = '0'.obs;
  final monthlyDelivery = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    getDeliveryData();
    getDeliveryStatus();
  }

  void getDeliveryStatus() {
    deliveryStatus.value = userStatus.$;

    printLog(userStatus.$.toString());
  }


  Future<void> getDeliveryData() async {
    var response = await HomeRepository().dashboardData();
    dailyDelivery.value = response.todayDeliveryAmount.toString();
    monthlyDelivery.value = response.monthlyDeliveryAmount.toString();
  }


  Future<void> setDeliveryStatus() async {
    try {
      userStatus.$ = !deliveryStatus.value;
      userStatus.save();
      var response = await HomeRepository().userStatus(
        userStatus.$ ? '1' : '0',
      );
      AppWidgets().getSnackBar(message: response.message);
    } catch (e) {
      AppWidgets().getSnackBar(message: 'Error updating delivery status');
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      AppWidgets().getSnackBar(message: 'Logged out successfully');

      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      AppWidgets().getSnackBar(message: 'Error during logout');
    }
  }
}
