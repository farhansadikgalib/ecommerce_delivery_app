import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/order/order_data_response.dart';
import 'package:delivery_app/app/data/repository/order/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllOrdersController extends GetxController {
  final orderList = <OrderData>[].obs;
  final filteredOrderList = <OrderData>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMoreData = true.obs;
  final selectedStatus = Rxn<String>(); // null means "All"
  int page = 1;
  final ScrollController scrollController = ScrollController();

  // Status mapping for display
  final statusOptions = <String, String>{
    'all': 'All Orders',
    '0': 'Ready',
    '1': 'Picked',
    '2': 'On Route',
    '3': 'Delivered',
    '4': 'Undelivered',
  };

  @override
  void onInit() {
    super.onInit();
    getOrderList();
    _setupScrollListener();

    // Listen to selectedStatus changes and apply filter
    ever(selectedStatus, (_) => _applyFilter());
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
      var response = await OrderRepository().getAllOrderData(page);

      orderList.addAll(response.data ?? []);
      _applyFilter();

      // Check if there's more data
      if ((response.data?.length ?? 0) < 10) {
        hasMoreData.value = false;
      }
    } catch (e) {
      AppWidgets().getSnackBar(
        message: 'Error loading orders: ${e.toString()}',
      );
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
        _applyFilter();

        // Check if there's more data
        if (response.data!.length < 10) {
          hasMoreData.value = false;
        }
      } else {
        hasMoreData.value = false;
        page--; // Revert page increment if no data
      }
    } catch (e) {
      page--; // Revert page increment on error
      AppWidgets().getSnackBar(
        message: 'Error loading more orders: ${e.toString()}',
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  void _applyFilter() {
    if (selectedStatus.value == null || selectedStatus.value == 'all') {
      filteredOrderList.assignAll(orderList);
    } else {
      filteredOrderList.assignAll(
        orderList
            .where((order) => order.deliveryStatus == selectedStatus.value)
            .toList(),
      );
    }
  }

  void filterByStatus(String? status) {
    selectedStatus.value = status;
  }

  void clearFilter() {
    selectedStatus.value = null;
  }

  String get currentFilterText {
    if (selectedStatus.value == null || selectedStatus.value == 'all') {
      return 'All Orders';
    }
    return statusOptions[selectedStatus.value] ?? 'Unknown Status';
  }

  bool get hasActiveFilter =>
      selectedStatus.value != null && selectedStatus.value != 'all';

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
