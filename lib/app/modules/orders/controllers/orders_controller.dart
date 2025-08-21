import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/order/order_data_response.dart';
import 'package:delivery_app/app/data/repository/order/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final orderList = <OrderData>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMoreData = true.obs;
  int page = 1;
  final ScrollController scrollController = ScrollController();

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
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (!isLoadingMore.value && hasMoreData.value) {
          loadMoreOrders();
        }
      }
    });
  }

  Future<void> getOrderList() async {
    try {
      isLoading.value = true;
      page = 1;
      hasMoreData.value = true;
      orderList.clear();
      var response = await OrderRepository().getPendingOrderData(page);
      orderList.addAll(response.data ?? []);

      // Check if there's more data (assuming 20 items per page based on API)
      if ((response.data?.length ?? 0) < 20) {
        hasMoreData.value = false;
      }
    } catch (e) {
      AppWidgets().getSnackBar(message: 'Error loading orders: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreOrders() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    try {
      isLoadingMore.value = true;
      page++;
      var response = await OrderRepository().getPendingOrderData(page);

      if (response.data != null && response.data!.isNotEmpty) {
        orderList.addAll(response.data!);

        // Check if there's more data (assuming 20 items per page)
        if (response.data!.length < 20) {
          hasMoreData.value = false;
        }
      } else {
        hasMoreData.value = false;
        page--; // Revert page increment if no data
      }
    } catch (e) {
      page--; // Revert page increment on error
      AppWidgets().getSnackBar(message: 'Error loading more orders: ${e.toString()}');
    } finally {
      isLoadingMore.value = false;
    }
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
    scrollController.dispose();
    super.onClose();
  }
}
