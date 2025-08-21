import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/order/order_data_response.dart';
import 'package:delivery_app/app/data/repository/order/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final orderList = <OrderData>[].obs;
  final isLoading = false.obs;

  // Undelivery reasons list
  final List<String> undeliveryReasons = [
    'Customer not available',
    'Wrong address',
    'Payment issue',
    'Customer refused delivery',
    'Incomplete address',
    'Customer requested reschedule',
    'Other',
  ];

  // Dialog state management
  final selectedReason = Rx<String?>(null);
  final customReasonController = TextEditingController();

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

  Future<void> setStatus(String orderId, String status, String reason, String amount) async {
    var response = await OrderRepository().setOrderStatus(
      orderId,
      status,
      reason,
      amount,
    );
    if (response.status == "success") {
      AppWidgets().getSnackBar(message: response.message);
      getOrderList();
    }
  }

  // Method to reset dialog state
  void resetDialogState() {
    selectedReason.value = null;
    customReasonController.clear();
  }

  @override
  void onClose() {
    customReasonController.dispose();
    super.onClose();
  }
}
