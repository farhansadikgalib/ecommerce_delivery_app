import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/order/order_data_response.dart';
import 'package:delivery_app/app/data/repository/order/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllOrderListController extends GetxController {
  final orderList = <OrderData>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMoreData = true.obs;
  int page = 1;
  final ScrollController scrollController = ScrollController();

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
      var response = await OrderRepository().getAllOrderData(page);
      orderList.clear();
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
      var response = await OrderRepository().getAllOrderData(page);

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

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
