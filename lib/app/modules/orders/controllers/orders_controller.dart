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
      var response = await OrderRepository().getOrderData();
      orderList.addAll(response.data?? []);
    }
  }