import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/order/order_data_response.dart';
import 'package:delivery_app/app/data/repository/order/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllOrdersController extends GetxController {
  final orderList = <OrderData>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getOrderList();
  }

  Future<void> getOrderList() async {
    isLoading.value = true;
    var response = await OrderRepository().getOrderData();
    orderList.clear();
    orderList.addAll(response.data ?? []);
    isLoading.value = false;
  }
}
