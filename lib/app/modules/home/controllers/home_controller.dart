import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/repository/home/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final deliveryStatus = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setDeliveryStatus() async {
    int status = deliveryStatus.value == true ? 1 : 0;

    var response = await HomeRepository().userStatus(status.toString());

    if (response.status == 'success') {
      AppWidgets().getSnackBar(message: response.message);
    }
  }
}
