import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/order/order_data_response.dart';
  import 'package:delivery_app/app/data/repository/order/order_repository.dart';
  import 'package:get/get.dart';

  class OrdersController extends GetxController {
    final orderList = <OrderData>[].obs;

    @override
    void onInit() {
      super.onInit();
      getOrderList();
    }

    Future<void> getOrderList() async {
      orderList.clear();
      var response = await OrderRepository().getOrderData();
      orderList.addAll(response.data?? []);
    }

    Future<void> setStatus(String orderId,String status, String reason,String
    amount)async{
      var response = await OrderRepository().setOrderStatus(
        orderList[0].id.toString(),
        status,
        reason,
        amount,
      );
      if (response.status == "success") {
        AppWidgets().getSnackBar(message: response.message);
        getOrderList();
      }

    }


  }